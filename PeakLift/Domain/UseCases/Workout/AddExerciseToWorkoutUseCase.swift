//
//  AddExerciseToWorkoutUseCase.swift
//  PeakLift
//

import Foundation

/// Appends a new `WorkoutExercise` entry to an existing workout.
struct AddExerciseToWorkoutUseCase: UseCase {
    private let workoutRepository: any WorkoutRepository
    private let exerciseRepository: any ExerciseRepository

    init(
        workoutRepository: any WorkoutRepository,
        exerciseRepository: any ExerciseRepository
    ) {
        self.workoutRepository = workoutRepository
        self.exerciseRepository = exerciseRepository
    }

    @discardableResult
    func execute(workoutID: UUID, exerciseID: UUID) async throws -> WorkoutExercise {
        guard var workout = try await workoutRepository.fetch(id: workoutID) else {
            throw DomainError.workoutNotFound
        }
        guard let exercise = try await exerciseRepository.fetch(id: exerciseID) else {
            throw DomainError.exerciseNotFound
        }
        let displayOrder = workout.exercises.count
        let workoutExercise = WorkoutExercise(
            exerciseID: exercise.id,
            exerciseNameSnapshot: exercise.name,
            displayOrder: displayOrder
        )
        workout.exercises.append(workoutExercise)
        workout.updatedAt = .now
        try await workoutRepository.update(workout)
        return workoutExercise
    }
}
