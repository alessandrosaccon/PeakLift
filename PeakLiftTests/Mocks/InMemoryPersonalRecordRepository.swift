//
//  InMemoryPersonalRecordRepository.swift
//  PeakLiftTests
//

import Foundation
@testable import PeakLift

final class InMemoryPersonalRecordRepository: PersonalRecordRepository, @unchecked Sendable {
    private var store: [UUID: PersonalRecord] = [:]

    func fetch(id: UUID) async throws -> PersonalRecord? { store[id] }
    func save(_ record: PersonalRecord) async throws { store[record.id] = record }
    func update(_ record: PersonalRecord) async throws { store[record.id] = record }
    func softDelete(id: UUID) async throws { store.removeValue(forKey: id) }

    func fetchLastPerformance(userID: UUID, exerciseID: UUID) async throws -> PersonalRecord? {
        store.values
            .filter { $0.userID == userID && $0.exerciseID == exerciseID }
            .max(by: { $0.achievedAt < $1.achievedAt })
    }
}
