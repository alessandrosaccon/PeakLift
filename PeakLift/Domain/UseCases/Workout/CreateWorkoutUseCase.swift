//
//  CreateWorkoutUseCase.swift
//  PeakLift
//

import Foundation

/// Creates a new workout and immediately transitions it to `.inProgress`.
struct CreateWorkoutUseCase: UseCase {
    private let workoutRepository: any WorkoutRepository

    init(workoutRepository: any WorkoutRepository) {
        self.workoutRepository = workoutRepository
    }

    @discardableResult
    func execute(userID: UUID, title: String? = nil) async throws -> Workout {
        var workout = Workout(
            userID: userID,
            title: title,
            status: .inProgress,
            startedAt: .now
        )
        workout.status = .inProgress
        try await workoutRepository.save(workout)
        return workout
    }
}
