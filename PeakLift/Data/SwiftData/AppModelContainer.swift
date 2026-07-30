//
//  AppModelContainer.swift
//  PeakLift
//

import SwiftData

enum AppModelContainer {
    static func make(inMemory: Bool = false) -> ModelContainer {
        let schema = Schema([AppMetadata.self])
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: inMemory
        )

        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Unable to initialise the local data store: \(error)")
        }
    }
}
