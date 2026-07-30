//
//  AppConfiguration.swift
//  PeakLift
//

import Foundation

enum AppEnvironment: String, Sendable {
    case development
    case staging
    case production
}

struct LocalFeatureFlags: Sendable {
    let cloudKitSyncEnabled: Bool
    let healthKitEnabled: Bool
    let remoteAIEnabled: Bool

    // nonisolated(unsafe): immutable after init, safe from any concurrency context.
    nonisolated(unsafe) static let allDisabled = LocalFeatureFlags(
        cloudKitSyncEnabled: false,
        healthKitEnabled: false,
        remoteAIEnabled: false
    )
}

/// Non-secret runtime configuration. Credentials and endpoints are deliberately
/// absent: they belong to build-time secure configuration or remote services.
struct AppConfiguration: Sendable {
    let appEnvironment: AppEnvironment
    let featureFlags: LocalFeatureFlags

    // nonisolated(unsafe): immutable after init, safe from any concurrency context.
    // Without this, Swift 6 infers @MainActor on this static let because the
    // module has an @main entry point, which contaminates DependencyContainer.live
    // and ultimately the Codable synthesis of all Domain entity structs.
    nonisolated(unsafe) static let current = AppConfiguration(
        appEnvironment: .development,
        featureFlags: .allDisabled
    )
}
