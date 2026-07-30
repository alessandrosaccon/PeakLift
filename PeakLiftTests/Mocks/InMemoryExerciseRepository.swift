//
//  InMemoryExerciseRepository.swift
//  PeakLiftTests
//

import Foundation
@testable import PeakLift

final class InMemoryExerciseRepository: ExerciseRepository, @unchecked Sendable {
    private var store: [UUID: Exercise] = [:]

    func fetch(id: UUID) async throws -> Exercise? { store[id] }

    func save(_ exercise: Exercise) async throws { store[exercise.id] = exercise }

    func update(_ exercise: Exercise) async throws {
        store[exercise.id] = exercise
    }

    func softDelete(id: UUID) async throws { store.removeValue(forKey: id) }

    func search(query: String, userID: UUID?) async throws -> [Exercise] {
        let q = query.lowercased()
        return store.values.filter { $0.normalizedName.contains(q) || $0.name.lowercased().contains(q) }
    }

    func fetchCatalog() async throws -> [Exercise] {
        store.values.filter { !$0.isCustom }
    }

    func fetchCustom(userID: UUID) async throws -> [Exercise] {
        store.values.filter { $0.isCustom && $0.ownerUserID == userID }
    }
}
