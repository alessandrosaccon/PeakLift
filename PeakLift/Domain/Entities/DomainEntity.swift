//
//  DomainEntity.swift
//  PeakLift
//

import Foundation

/// Canonical protocol for all Domain-layer entities.
/// - Pure value type (struct)
/// - No @MainActor, no SwiftUI/Observation/SwiftData/CloudKit dependency
/// - ID is always UUID (satisfies Identifiable + Sendable + Hashable)
protocol DomainEntity: Identifiable, Codable, Sendable, Hashable where ID == UUID {}
