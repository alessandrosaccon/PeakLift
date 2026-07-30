//
//  RepositoryContracts.swift
//  PeakLift
//

import Foundation

// MARK: - UserProfile

protocol UserProfileRepository: Sendable {
    func fetch(id: UUID) async throws -> UserProfile?
    func save(_ profile: UserProfile) async throws
    func update(_ profile: UserProfile) async throws
    func softDelete(id: UUID) async throws
}

// MARK: - Exercise

protocol ExerciseRepository: Sendable {
    /// Fetch a single exercise by id.
    func fetch(id: UUID) async throws -> Exercise?
    /// Persist a new exercise.
    func save(_ exercise: Exercise) async throws
    func update(_ exercise: Exercise) async throws
    func softDelete(id: UUID) async throws
    /// Full-text search on name / normalizedName.
    func search(query: String, userID: UUID?) async throws -> [Exercise]
    /// Catalog (non-custom) exercises.
    func fetchCatalog() async throws -> [Exercise]
    /// Custom exercises created by a specific user.
    func fetchCustom(userID: UUID) async throws -> [Exercise]
}

// MARK: - Workout

protocol WorkoutRepository: Sendable {
    func fetch(id: UUID) async throws -> Workout?
    func save(_ workout: Workout) async throws
    func update(_ workout: Workout) async throws
    func softDelete(id: UUID) async throws
    /// Returns the single workout whose status is `.inProgress` for the given user, if any.
    func fetchInProgress(userID: UUID) async throws -> Workout?
    /// Returns all completed workouts whose `completedAt` falls within the given range.
    func fetchCompleted(userID: UUID, from: Date, to: Date) async throws -> [Workout]
}

// MARK: - PersonalRecord

protocol PersonalRecordRepository: Sendable {
    func fetch(id: UUID) async throws -> PersonalRecord?
    func save(_ record: PersonalRecord) async throws
    func update(_ record: PersonalRecord) async throws
    func softDelete(id: UUID) async throws
    /// Last recorded performance (any record type) for a given exercise.
    func fetchLastPerformance(userID: UUID, exerciseID: UUID) async throws -> PersonalRecord?
}

// MARK: - ProgressMetric

protocol ProgressMetricRepository: Sendable {
    func fetch(id: UUID) async throws -> ProgressMetric?
    func save(_ metric: ProgressMetric) async throws
    func update(_ metric: ProgressMetric) async throws
    func softDelete(id: UUID) async throws
}

// MARK: - Consent

protocol ConsentRepository: Sendable {
    /// Fetch the current consent record for a specific type.
    func fetch(userID: UUID, type: ConsentType) async throws -> ConsentRecord?
    func save(_ record: ConsentRecord) async throws
    func update(_ record: ConsentRecord) async throws
}

// MARK: - Insight

protocol InsightRepository: Sendable {
    func fetch(id: UUID) async throws -> Insight?
    func save(_ insight: Insight) async throws
    func update(_ insight: Insight) async throws
    func softDelete(id: UUID) async throws
    /// Returns all non-archived insights for a user.
    func fetchActive(userID: UUID) async throws -> [Insight]
}
