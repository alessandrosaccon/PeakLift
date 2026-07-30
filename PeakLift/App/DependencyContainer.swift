//
//  DependencyContainer.swift
//  PeakLift
//

import Foundation

/// Shared live instance declared at file scope.
/// File-scope globals are always nonisolated in Swift — the compiler cannot
/// infer @MainActor on them even inside an @main module. This breaks the
/// isolation chain that was contaminating Domain entity Codable conformances.
let sharedDependencies = DependencyContainer(configuration: .current)

/// Composition root for dependencies exposed through Domain protocols.
/// Plain `final class: Sendable`, no @MainActor, no actor isolation.
/// Thread-safety on `factories` is provided by NSLock.
final class DependencyContainer: Sendable {

    let configuration: AppConfiguration

    private let lock = NSLock()
    private nonisolated(unsafe) var factories: [ObjectIdentifier: Any] = [:]

    init(configuration: AppConfiguration) {
        self.configuration = configuration
    }

    func register<Dependency>(_ type: Dependency.Type, factory: @escaping @Sendable () -> Dependency) {
        lock.withLock { factories[ObjectIdentifier(type)] = factory }
    }

    func resolve<Dependency>(_ type: Dependency.Type) -> Dependency {
        lock.withLock {
            guard let factory = factories[ObjectIdentifier(type)] as? @Sendable () -> Dependency else {
                preconditionFailure("No dependency registered for \(type).")
            }
            return factory()
        }
    }
}
