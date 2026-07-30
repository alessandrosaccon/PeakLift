//
//  DependencyContainer.swift
//  PeakLift
//

import Foundation

/// Composition root for dependencies exposed through Domain protocols.
///
/// Implemented as a plain `final class` (not `actor`, not `@MainActor`) so that
/// Swift 6 strict-concurrency checking does not propagate any actor isolation to
/// Domain-layer types that conform to `Sendable` (e.g. entity `Codable` synthesis).
///
/// Thread-safety on `factories` is provided by `NSLock`, which gives the same
/// mutual-exclusion guarantee as an `actor` for this synchronous, non-reentrant
/// use case.
final class DependencyContainer: Sendable {

    /// Shared live instance. `static let` on a class is initialised lazily and
    /// atomically by the Swift runtime — no additional locking required.
    static let live = DependencyContainer(configuration: .current)

    let configuration: AppConfiguration

    private let lock = NSLock()
    // `factories` is mutated only while `lock` is held, so the class is
    // technically Sendable even though the dictionary is not inherently so.
    // The nonisolated(unsafe) suppresses the compiler warning for this
    // specific stored property only — not for the entire type.
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
