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

    nonisolated(unsafe) static let current = AppConfiguration(
        appEnvironment: .development,
        featureFlags: .allDisabled
    )
}
