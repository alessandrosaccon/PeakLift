//
//  SaveWorkoutDraftUseCase.swift
//  PeakLift
//

import Foundation

/// Persists the current state of a workout as a draft without completing it.
struct SaveWorkoutDraftUseCase: UseCase {
    private let workoutRepository: any WorkoutRepository

    init(workoutRepository: any WorkoutRepository) {
        self.workoutRepository = workoutRepository
    }

    func execute(workout: Workout) async throws {
        guard workout.status == .draft || workout.status == .inProgress else {
            throw DomainError.invalidWorkoutState(workout.status)
        }
        var draft = workout
        draft.status = .draft
        draft.updatedAt = .now
        try await workoutRepository.update(draft)
    }
}
