//
//  DependencyContainer.swift
//  PeakLift
//

import Foundation

/// Composition root for dependencies exposed through Domain protocols.
///
/// Implemented as a plain `final class: Sendable` (not `actor`, not `@MainActor`)
/// so that Swift 6 strict-concurrency checking does not propagate any actor
/// isolation to Domain-layer types that conform to `Sendable`.
///
/// Thread-safety on `factories` is provided by `NSLock`.
final class DependencyContainer: Sendable {

    // nonisolated(unsafe): written once at app startup before any concurrent
    // access. Depends on AppConfiguration.current which is also nonisolated(unsafe).
    nonisolated(unsafe) static let live = DependencyContainer(configuration: .current)

    let configuration: AppConfiguration

    private let lock = NSLock()
    // Mutated only while `lock` is held — safe despite not being inherently Sendable.
    private nonisolated(unsafe) var factories: [ObjectIdentifier: Any] = [:]

    init(configuration: AppConfiguration) {
        self.configuration = configuration
    }

    /// Registers a local implementation for a protocol-bound dependency.
    func register<Dependency>(_ type: Dependency.Type, factory: @escaping @Sendable () -> Dependency) {
        lock.withLock { factories[ObjectIdentifier(type)] = factory }
    }

    /// Resolves a registered dependency. Precondition-fails if not registered.
    func resolve<Dependency>(_ type: Dependency.Type) -> Dependency {
        lock.withLock {
            guard let factory = factories[ObjectIdentifier(type)] as? @Sendable () -> Dependency else {
                preconditionFailure("No dependency registered for \(type).")
            }
            return factory()
        }
    }
}
