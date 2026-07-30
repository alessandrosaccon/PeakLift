//
//  DependencyContainer.swift
//  PeakLift
//

import Foundation

/// Composition root for dependencies exposed through Domain protocols.
/// Implemented as an `actor` to guarantee thread-safe mutation of the
/// factories registry without requiring @MainActor (which would contaminate
/// Sendable conformances in the Domain layer under Swift 6 strict concurrency).
actor DependencyContainer {
    static let live = DependencyContainer(configuration: .current)

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
