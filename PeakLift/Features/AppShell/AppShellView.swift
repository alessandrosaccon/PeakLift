//
//  AppShellView.swift
//  PeakLift
//

import SwiftUI

/// Root presentation shell. Feature screens remain isolated behind their tabs.
struct AppShellView: View {
    let dependencies: AppDependencies

    @State private var selectedTab: AppTab = .dashboard

    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem { Label("Dashboard", systemImage: "house") }
                .tag(AppTab.dashboard)

            AnalyticsView()
                .tabItem { Label("Analytics", systemImage: "chart.xyaxis.line") }
                .tag(AppTab.analytics)

            CoachView()
                .tabItem { Label("Coach", systemImage: "sparkles") }
                .tag(AppTab.coach)

            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
                .tag(AppTab.profile)
        }
    }
}

#Preview {
    AppShellView(dependencies: .live)
}
