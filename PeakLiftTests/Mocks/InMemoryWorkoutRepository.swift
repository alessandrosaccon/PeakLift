//
//  InMemoryWorkoutRepository.swift
//  PeakLiftTests
//

import Foundation
@testable import PeakLift

final class InMemoryWorkoutRepository: WorkoutRepository, @unchecked Sendable {
    private var store: [UUID: Workout] = [:]

    func fetch(id: UUID) async throws -> Workout? {
        store[id]
    }

    func save(_ workout: Workout) async throws {
        store[workout.id] = workout
    }

    func update(_ workout: Workout) async throws {
        guard store[workout.id] != nil else { throw DomainError.workoutNotFound }
        store[workout.id] = workout
    }

    func softDelete(id: UUID) async throws {
        store.removeValue(forKey: id)
    }

    func fetchInProgress(userID: UUID) async throws -> Workout? {
        store.values.first { $0.userID == userID && $0.status == .inProgress }
    }

    func fetchCompleted(userID: UUID, from: Date, to: Date) async throws -> [Workout] {
        store.values.filter {
            $0.userID == userID &&
            $0.status == .completed &&
            ($0.completedAt.map { $0 >= from && $0 <= to } ?? false)
        }
    }
}
