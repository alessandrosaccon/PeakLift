//
//  CompleteWorkoutUseCase.swift
//  PeakLift
//

import Foundation

/// Marks a workout as completed and computes summary statistics.
///
/// Rules:
/// - Status transitions to `.completed`.
/// - `completedAt` is set to now.
/// - `durationSeconds` = completedAt − startedAt (in seconds).
/// - `totalVolumeKg` sums only sets whose `status == .completed` (skipped excluded).
/// - `workingSetCount` counts only `status == .completed` sets whose type is
///   `.working`, `.drop`, or `.failure` (warmups excluded).
struct CompleteWorkoutUseCase: UseCase {
    private let workoutRepository: any WorkoutRepository

    init(workoutRepository: any WorkoutRepository) {
        self.workoutRepository = workoutRepository
    }

    struct Result: Sendable {
        let workout: Workout
        let durationSeconds: TimeInterval
        let totalVolumeKg: Double
        let workingSetCount: Int
    }

    func execute(workoutID: UUID) async throws -> Result {
        guard var workout = try await workoutRepository.fetch(id: workoutID) else {
            throw DomainError.workoutNotFound
        }
        guard workout.status == .inProgress || workout.status == .draft else {
            throw DomainError.workoutAlreadyCompleted
        }

        let completedAt = Date.now
        let durationSeconds = completedAt.timeIntervalSince(workout.startedAt)

        let allSets = workout.exercises.flatMap(\.sets)
        let completedSets = allSets.filter { $0.status == .completed }
        let totalVolumeKg = completedSets.reduce(0.0) { $0 + $1.weightKg * Double($1.repetitions) }
        let workingSetCount = completedSets.filter { $0.contributesToWorkingSetCount }.count

        workout.status = .completed
        workout.completedAt = completedAt
        workout.updatedAt = completedAt

        try await workoutRepository.update(workout)

        return Result(
            workout: workout,
            durationSeconds: durationSeconds,
            totalVolumeKg: totalVolumeKg,
            workingSetCount: workingSetCount
        )
    }
}
