//
//  FoundationComponents+Previews.swift
//  PeakLift
//

import SwiftUI

private struct FoundationComponentsPreview: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: PeakLiftSpacing.x5) {
                SectionHeader(title: "Panoramica", actionTitle: "Vedi tutto") {}
                MetricLabel(title: "Volume settimanale", value: "12.450", unit: "kg")
                GlassCard(emphasis: .primary) {
                    Text("Insight prioritario")
                        .font(PeakLiftTypography.title3)
                }
                PrimaryButton("Inizia workout", systemImage: "play.fill") {}
                SecondaryButton("Visualizza analytics", systemImage: "chart.xyaxis.line") {}
                DestructiveButton("Elimina bozza") {}
                HStack {
                    IconButton(systemImage: "plus", accessibilityLabel: "Aggiungi") {}
                    LoadingStateView()
                }
                EmptyStateView(
                    title: "Nessun workout",
                    message: "Registra il tuo primo allenamento per iniziare.",
                    systemImage: "figure.strengthtraining.traditional"
                )
                ErrorStateView(message: "Riprova tra poco.", retryTitle: "Riprova") {}
            }
            .padding(PeakLiftSpacing.x6)
        }
        .peakLiftPageBackground()
    }
}

#Preview("Foundation · Light") {
    FoundationComponentsPreview()
        .preferredColorScheme(.light)
}

#Preview("Foundation · Dark") {
    FoundationComponentsPreview()
        .preferredColorScheme(.dark)
}
