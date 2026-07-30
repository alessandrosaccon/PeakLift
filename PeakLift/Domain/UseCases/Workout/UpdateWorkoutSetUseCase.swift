//
//  UpdateWorkoutSetUseCase.swift
//  PeakLift
//

import Foundation

/// Updates mutable fields of an existing `WorkoutSet`.
struct UpdateWorkoutSetUseCase: UseCase {
    private let workoutRepository: any WorkoutRepository

    init(workoutRepository: any WorkoutRepository) {
        self.workoutRepository = workoutRepository
    }

    struct Patch: Sendable {
        var weightKg: Double?
        var repetitions: Int?
        var rpe: Double?
        var rir: Double?
        var status: SetStatus?
        var setType: SetType?
        var notes: String?
    }

    func execute(workoutID: UUID, workoutExerciseID: UUID, setID: UUID, patch: Patch) async throws {
        guard var workout = try await workoutRepository.fetch(id: workoutID) else {
            throw DomainError.workoutNotFound
        }
        guard let exerciseIndex = workout.exercises.firstIndex(where: { $0.id == workoutExerciseID }) else {
            throw DomainError.workoutExerciseNotFound
        }
        guard let setIndex = workout.exercises[exerciseIndex].sets.firstIndex(where: { $0.id == setID }) else {
            throw DomainError.workoutSetNotFound
        }
        var set = workout.exercises[exerciseIndex].sets[setIndex]
        let newWeight = patch.weightKg ?? set.weightKg
        let newReps = patch.repetitions ?? set.repetitions
        let newRPE = patch.rpe ?? set.rpe
        let newRIR = patch.rir ?? set.rir
        let newType = patch.setType ?? set.setType
        let newStatus = patch.status ?? set.status
        let newNotes = patch.notes ?? set.notes
        set = try WorkoutSet(
            id: set.id,
            setOrder: set.setOrder,
            weightKg: newWeight,
            repetitions: newReps,
            rpe: newRPE,
            rir: newRIR,
            setType: newType,
            status: newStatus,
            completedAt: newStatus == .completed ? (set.completedAt ?? .now) : set.completedAt,
            restDurationSeconds: set.restDurationSeconds,
            notes: newNotes,
            createdAt: set.createdAt,
            updatedAt: .now
        )
        workout.exercises[exerciseIndex].sets[setIndex] = set
        workout.exercises[exerciseIndex].updatedAt = .now
        workout.updatedAt = .now
        try await workoutRepository.update(workout)
    }
}
