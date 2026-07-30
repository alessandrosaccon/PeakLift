//
//  PeakLiftApp.swift
//  PeakLift
//
//  Created by Alessandro Saccon on 30/07/2026.
//

import SwiftUI
import SwiftData

@main
struct PeakLiftApp: App {
    private let dependencies = DependencyContainer.live
    private let modelContainer = AppModelContainer.make()

    var body: some Scene {
        WindowGroup {
            AppShellView(dependencies: dependencies)
        }
        .modelContainer(modelContainer)
    }
}
