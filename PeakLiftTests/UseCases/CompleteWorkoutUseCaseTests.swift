//
//  CompleteWorkoutUseCaseTests.swift
//  PeakLiftTests
//

import XCTest
@testable import PeakLift

final class CompleteWorkoutUseCaseTests: XCTestCase {

    // MARK: - Helpers

    private func makeSet(
        weightKg: Double = 100,
        reps: Int = 5,
        type: SetType = .working,
        status: SetStatus = .completed
    ) throws -> WorkoutSet {
        try WorkoutSet(
            setOrder: 0,
            weightKg: weightKg,
            repetitions: reps,
            setType: type,
            status: status
        )
    }

    private func makeWorkout(
        status: WorkoutStatus = .inProgress,
        exercises: [WorkoutExercise] = []
    ) -> Workout {
        Workout(
            userID: UUID(),
            status: status,
            startedAt: Date(timeIntervalSinceNow: -3600), // 1 hour ago
            exercises: exercises
        )
    }

    // MARK: - Tests

    func test_completeWorkout_setsStatusAndCompletedAt() async throws {
        let repo = InMemoryWorkoutRepository()
        let workout = makeWorkout()
        try await repo.save(workout)

        let useCase = CompleteWorkoutUseCase(workoutRepository: repo)
        let result = try await useCase.execute(workoutID: workout.id)

        XCTAssertEqual(result.workout.status, .completed)
        XCTAssertNotNil(result.workout.completedAt)
    }

    func test_completeWorkout_calculatesDurationApproximately() async throws {
        let repo = InMemoryWorkoutRepository()
        let workout = makeWorkout() // startedAt = 1 hour ago
        try await repo.save(workout)

        let useCase = CompleteWorkoutUseCase(workoutRepository: repo)
        let result = try await useCase.execute(workoutID: workout.id)

        // Duration should be roughly 3600s ± 5s
        XCTAssertEqual(result.durationSeconds, 3600, accuracy: 5)
    }

    func test_completeWorkout_excludesSkippedFromVolume() async throws {
        let repo = InMemoryWorkoutRepository()
        let completedSet = try makeSet(weightKg: 100, reps: 5, status: .completed)
        let skippedSet  = try makeSet(weightKg: 100, reps: 5, status: .skipped)
        var exercise = WorkoutExercise(
            exerciseID: UUID(),
            exerciseNameSnapshot: "Squat",
            displayOrder: 0,
            sets: [completedSet, skippedSet]
        )
        let workout = makeWorkout(exercises: [exercise])
        try await repo.save(workout)

        let useCase = CompleteWorkoutUseCase(workoutRepository: repo)
        let result = try await useCase.execute(workoutID: workout.id)

        // Only the completed set contributes: 100 * 5 = 500
        XCTAssertEqual(result.totalVolumeKg, 500, accuracy: 0.001)
    }

    func test_completeWorkout_excludesWarmupFromWorkingSetCount() async throws {
        let repo = InMemoryWorkoutRepository()
        let warmup  = try makeSet(weightKg: 60,  reps: 10, type: .warmup,  status: .completed)
        let working = try makeSet(weightKg: 100, reps: 5,  type: .working, status: .completed)
        let drop    = try makeSet(weightKg: 80,  reps: 8,  type: .drop,    status: .completed)
        let exercise = WorkoutExercise(
            exerciseID: UUID(),
            exerciseNameSnapshot: "Bench Press",
            displayOrder: 0,
            sets: [warmup, working, drop]
        )
        let workout = makeWorkout(exercises: [exercise])
        try await repo.save(workout)

        let useCase = CompleteWorkoutUseCase(workoutRepository: repo)
        let result = try await useCase.execute(workoutID: workout.id)

        // warmup is excluded → only working + drop = 2
        XCTAssertEqual(result.workingSetCount, 2)
    }

    func test_completeWorkout_throwsWhenAlreadyCompleted() async throws {
        let repo = InMemoryWorkoutRepository()
        let workout = makeWorkout(status: .completed)
        try await repo.save(workout)

        let useCase = CompleteWorkoutUseCase(workoutRepository: repo)
        do {
            _ = try await useCase.execute(workoutID: workout.id)
            XCTFail("Expected DomainError.workoutAlreadyCompleted")
        } catch DomainError.workoutAlreadyCompleted {
            // expected
        }
    }

    func test_completeWorkout_throwsWhenNotFound() async throws {
        let repo = InMemoryWorkoutRepository()
        let useCase = CompleteWorkoutUseCase(workoutRepository: repo)
        do {
            _ = try await useCase.execute(workoutID: UUID())
            XCTFail("Expected DomainError.workoutNotFound")
        } catch DomainError.workoutNotFound {
            // expected
        }
    }

    func test_completeWorkout_multipleExercises_aggregatesCorrectly() async throws {
        let repo = InMemoryWorkoutRepository()
        let set1 = try makeSet(weightKg: 100, reps: 5, type: .working, status: .completed)
        let set2 = try makeSet(weightKg: 80,  reps: 8, type: .working, status: .completed)
        let skipped = try makeSet(weightKg: 60, reps: 10, type: .working, status: .skipped)
        let warmup  = try makeSet(weightKg: 40, reps: 15, type: .warmup,  status: .completed)

        let ex1 = WorkoutExercise(exerciseID: UUID(), exerciseNameSnapshot: "Squat",      displayOrder: 0, sets: [warmup, set1])
        let ex2 = WorkoutExercise(exerciseID: UUID(), exerciseNameSnapshot: "Bench Press", displayOrder: 1, sets: [set2, skipped])
        let workout = makeWorkout(exercises: [ex1, ex2])
        try await repo.save(workout)

        let useCase = CompleteWorkoutUseCase(workoutRepository: repo)
        let result = try await useCase.execute(workoutID: workout.id)

        // volume: warmup counts (it's completed), skipped doesn't
        // warmup: 40*15=600, set1: 100*5=500, set2: 80*8=640 → total 1740
        XCTAssertEqual(result.totalVolumeKg, 1740, accuracy: 0.001)
        // workingSetCount: set1 (working) + set2 (working) = 2; warmup excluded, skipped excluded
        XCTAssertEqual(result.workingSetCount, 2)
    }
}
