//
//  PeakLiftApp.swift
//  PeakLift
//

import SwiftUI
import SwiftData

@main
struct PeakLiftApp: App {
    private let dependencies = sharedDependencies
    private let modelContainer = AppModelContainer.make()

    var body: some Scene {
        WindowGroup {
            AppShellView(dependencies: dependencies)
        }
        .modelContainer(modelContainer)
    }
}
