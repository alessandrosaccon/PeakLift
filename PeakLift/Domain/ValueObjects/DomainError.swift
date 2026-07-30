//
//  DomainError.swift
//  PeakLift
//

import Foundation

enum DomainError: Error, Equatable, Sendable {
    case workoutNotFound
    case workoutNotInProgress
    case workoutAlreadyCompleted
    case exerciseNotFound
    case workoutExerciseNotFound
    case workoutSetNotFound
    case invalidWorkoutState(WorkoutStatus)
    case noActiveWorkout
}
