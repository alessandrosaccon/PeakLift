//
//  ServiceContracts.swift
//  PeakLift
//

import Foundation

/// Calculates deterministic fitness metrics locally. No metric is implemented yet.
protocol AnalyticsComputing: Sendable {}

/// Boundary for AI interpretation. The domain never knows a provider SDK or API key.
protocol AIService: Sendable {}

/// Boundary for explicit, user-controlled cloud synchronisation.
protocol CloudSyncCoordinating: Sendable {}

/// Boundary for optional HealthKit access.
protocol HealthDataProviding: Sendable {}
