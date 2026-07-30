//
//  DependencyContainer.swift
//  PeakLift
//

import Foundation

/// Composition root for dependencies exposed through Domain protocols.
/// No remote service is registered in the foundation phase.
@MainActor
final class DependencyContainer {
    static let live = DependencyContainer(configuration: .current)

    let configuration: AppConfiguration
    private var factories: [ObjectIdentifier: Any] = [:]

    init(configuration: AppConfiguration) {
        self.configuration = configuration
    }

    /// Registers a local implementation for a protocol-bound dependency.
    /// Feature composition will add registrations when implementations exist.
    func register<Dependency>(_ type: Dependency.Type, factory: @escaping () -> Dependency) {
        factories[ObjectIdentifier(type)] = factory
    }

    func resolve<Dependency>(_ type: Dependency.Type) -> Dependency {
        guard let factory = factories[ObjectIdentifier(type)] as? () -> Dependency else {
            preconditionFailure("No dependency registered for \(type).")
        }
        return factory()
    }
}
