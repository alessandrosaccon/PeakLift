//
//  RepositoryContracts.swift
//  PeakLift
//

import Foundation

/// Domain boundaries. Their operations will be introduced together with the
/// respective entities and use cases, keeping features independent of storage.
protocol WorkoutRepository: Sendable {}
protocol ExerciseRepository: Sendable {}
protocol UserProfileRepository: Sendable {}
protocol ConsentRepository: Sendable {}
protocol InsightRepository: Sendable {}
