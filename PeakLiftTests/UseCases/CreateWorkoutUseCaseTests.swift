//
//  CreateWorkoutUseCaseTests.swift
//  PeakLiftTests
//

import XCTest
@testable import PeakLift

final class CreateWorkoutUseCaseTests: XCTestCase {

    func test_createWorkout_statusIsInProgress() async throws {
        let repo = InMemoryWorkoutRepository()
        let useCase = CreateWorkoutUseCase(workoutRepository: repo)
        let userID = UUID()
        let workout = try await useCase.execute(userID: userID, title: "Morning Push")
        XCTAssertEqual(workout.status, .inProgress)
        XCTAssertEqual(workout.userID, userID)
        XCTAssertEqual(workout.title, "Morning Push")
    }

    func test_createWorkout_isPersisted() async throws {
        let repo = InMemoryWorkoutRepository()
        let useCase = CreateWorkoutUseCase(workoutRepository: repo)
        let workout = try await useCase.execute(userID: UUID())
        let fetched = try await repo.fetch(id: workout.id)
        XCTAssertNotNil(fetched)
    }
}
