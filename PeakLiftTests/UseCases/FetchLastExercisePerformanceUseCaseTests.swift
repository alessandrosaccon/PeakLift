//
//  FetchLastExercisePerformanceUseCaseTests.swift
//  PeakLiftTests
//

import XCTest
@testable import PeakLift

final class FetchLastExercisePerformanceUseCaseTests: XCTestCase {

    func test_fetchLastPerformance_returnsLatestByDate() async throws {
        let repo = InMemoryPersonalRecordRepository()
        let userID = UUID()
        let exerciseID = UUID()
        let workoutID = UUID()

        let older = PersonalRecord(
            userID: userID,
            exerciseID: exerciseID,
            recordType: .maxWeight,
            value: 100,
            unit: "kg",
            achievedAt: Date(timeIntervalSinceNow: -7200),
            workoutID: workoutID
        )
        let newer = PersonalRecord(
            userID: userID,
            exerciseID: exerciseID,
            recordType: .maxWeight,
            value: 105,
            unit: "kg",
            achievedAt: Date(timeIntervalSinceNow: -3600),
            workoutID: workoutID
        )
        try await repo.save(older)
        try await repo.save(newer)

        let useCase = FetchLastExercisePerformanceUseCase(personalRecordRepository: repo)
        let result = try await useCase.execute(userID: userID, exerciseID: exerciseID)
        XCTAssertEqual(result?.id, newer.id)
    }

    func test_fetchLastPerformance_returnsNilWhenNone() async throws {
        let repo = InMemoryPersonalRecordRepository()
        let useCase = FetchLastExercisePerformanceUseCase(personalRecordRepository: repo)
        let result = try await useCase.execute(userID: UUID(), exerciseID: UUID())
        XCTAssertNil(result)
    }
}
