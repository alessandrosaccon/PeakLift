//
//  DependencyContainer.swift
//  PeakLift
//

import Foundation

/// Composition root for dependencies exposed through Domain protocols.
/// Implemented as an `actor` to guarantee thread-safe mutation of the
/// factories registry without contaminating Domain layer Sendable conformances.
actor DependencyContainer {

    /// Shared live instance. Marked `nonisolated(unsafe)` so it can be
    /// referenced as a default value from non-isolated contexts (e.g. SwiftUI
    /// property initializers). Safe because `live` is assigned exactly once
    /// before any concurrent access occurs.
    nonisolated(unsafe) static let live = DependencyContainer(configuration: .current)

    let configuration: AppConfiguration
    private var factories: [ObjectIdentifier: Any] = [:]

    init(configuration: AppConfiguration) {
        self.configuration = configuration
    }

    /// Registers a local implementation for a protocol-bound dependency.
    func register<Dependency>(_ type: Dependency.Type, factory: @escaping @Sendable () -> Dependency) {
        factories[ObjectIdentifier(type)] = factory
    }

    /// Resolves a registered dependency. Precondition-fails if not registered.
    func resolve<Dependency>(_ type: Dependency.Type) -> Dependency {
        guard let factory = factories[ObjectIdentifier(type)] as? @Sendable () -> Dependency else {
            preconditionFailure("No dependency registered for \(type).")
        }
        return factory()
    }
}
