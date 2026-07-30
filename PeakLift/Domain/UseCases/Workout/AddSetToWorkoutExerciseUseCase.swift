//
//  AddSetToWorkoutExerciseUseCase.swift
//  PeakLift
//

import Foundation

/// Appends a new `WorkoutSet` to a specific exercise within a workout.
struct AddSetToWorkoutExerciseUseCase: UseCase {
    private let workoutRepository: any WorkoutRepository

    init(workoutRepository: any WorkoutRepository) {
        self.workoutRepository = workoutRepository
    }

    struct Input: Sendable {
        let workoutID: UUID
        let workoutExerciseID: UUID
        let weightKg: Double
        let repetitions: Int
        let setType: SetType
        let rpe: Double?
        let rir: Double?
        let notes: String?

        init(
            workoutID: UUID,
            workoutExerciseID: UUID,
            weightKg: Double,
            repetitions: Int,
            setType: SetType = .working,
            rpe: Double? = nil,
            rir: Double? = nil,
            notes: String? = nil
        ) {
            self.workoutID = workoutID
            self.workoutExerciseID = workoutExerciseID
            self.weightKg = weightKg
            self.repetitions = repetitions
            self.setType = setType
            self.rpe = rpe
            self.rir = rir
            self.notes = notes
        }
    }

    @discardableResult
    func execute(input: Input) async throws -> WorkoutSet {
        guard var workout = try await workoutRepository.fetch(id: input.workoutID) else {
            throw DomainError.workoutNotFound
        }
        guard let exerciseIndex = workout.exercises.firstIndex(where: { $0.id == input.workoutExerciseID }) else {
            throw DomainError.workoutExerciseNotFound
        }
        let setOrder = workout.exercises[exerciseIndex].sets.count
        let newSet = try WorkoutSet(
            setOrder: setOrder,
            weightKg: input.weightKg,
            repetitions: input.repetitions,
            rpe: input.rpe,
            rir: input.rir,
            setType: input.setType,
            notes: input.notes
        )
        workout.exercises[exerciseIndex].sets.append(newSet)
        workout.exercises[exerciseIndex].updatedAt = .now
        workout.updatedAt = .now
        try await workoutRepository.update(workout)
        return newSet
    }
}
