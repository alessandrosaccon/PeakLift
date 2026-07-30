//
//  CancelWorkoutUseCaseTests.swift
//  PeakLiftTests
//

import XCTest
@testable import PeakLift

final class CancelWorkoutUseCaseTests: XCTestCase {

    func test_cancelWorkout_setsStatusCancelled() async throws {
        let repo = InMemoryWorkoutRepository()
        let workout = Workout(userID: UUID(), status: .inProgress)
        try await repo.save(workout)

        let useCase = CancelWorkoutUseCase(workoutRepository: repo)
        try await useCase.execute(workoutID: workout.id)

        let fetched = try await repo.fetch(id: workout.id)
        XCTAssertEqual(fetched?.status, .cancelled)
    }

    func test_cancelWorkout_throwsIfAlreadyCancelled() async throws {
        let repo = InMemoryWorkoutRepository()
        let workout = Workout(userID: UUID(), status: .cancelled)
        try await repo.save(workout)

        let useCase = CancelWorkoutUseCase(workoutRepository: repo)
        do {
            try await useCase.execute(workoutID: workout.id)
            XCTFail("Should have thrown")
        } catch DomainError.invalidWorkoutState {
            // expected
        }
    }
}
