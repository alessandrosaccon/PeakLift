//
//  CancelWorkoutUseCase.swift
//  PeakLift
//

import Foundation

/// Cancels an in-progress or draft workout.
struct CancelWorkoutUseCase: UseCase {
    private let workoutRepository: any WorkoutRepository

    init(workoutRepository: any WorkoutRepository) {
        self.workoutRepository = workoutRepository
    }

    func execute(workoutID: UUID) async throws {
        guard var workout = try await workoutRepository.fetch(id: workoutID) else {
            throw DomainError.workoutNotFound
        }
        guard workout.status == .inProgress || workout.status == .draft else {
            throw DomainError.invalidWorkoutState(workout.status)
        }
        workout.status = .cancelled
        workout.updatedAt = .now
        try await workoutRepository.update(workout)
    }
}
