//
//  InsightCard.swift
//  PeakLift
//

import SwiftUI

enum InsightCategory {
    case progression, volume, consistency, balance, insufficientData, coach

    var label: String {
        switch self {
        case .progression: "Progressione"
        case .volume: "Volume"
        case .consistency: "Costanza"
        case .balance: "Equilibrio"
        case .insufficientData: "Dati insufficienti"
        case .coach: "AI Coach"
        }
    }

    var symbol: String {
        switch self {
        case .progression: "chart.line.uptrend.xyaxis"
        case .volume: "scalemass"
        case .consistency: "flame"
        case .balance: "figure.strengthtraining.traditional"
        case .insufficientData: "info.circle"
        case .coach: "sparkles"
        }
    }

    var color: Color {
        switch self {
        case .progression: PeakLiftColor.secondary
        case .volume: PeakLiftColor.primary
        case .consistency: PeakLiftColor.success
        case .balance: PeakLiftColor.warning
        case .insufficientData: PeakLiftColor.info
        case .coach: PeakLiftColor.accentViolet
        }
    }
}

struct InsightCard: View {
    let category: InsightCategory
    let title: String
    let summary: String
    let period: String
    let confidence: String
    let suggestedAction: String?

    var body: some View {
        GlassCard(emphasis: category == .coach ? .ai : .neutral) {
            VStack(alignment: .leading, spacing: PeakLiftSpacing.x3) {
                Label(category.label, systemImage: category.symbol)
                    .font(PeakLiftTypography.caption)
                    .foregroundStyle(category.color)
                Text(title).font(PeakLiftTypography.title3)
                Text(summary).font(PeakLiftTypography.callout).foregroundStyle(.secondary)
                HStack {
                    Label(period, systemImage: "calendar")
                    Spacer()
                    Text("Confidenza: \(confidence)")
                }
                .font(PeakLiftTypography.caption)
                .foregroundStyle(.secondary)
                if let suggestedAction {
                    Text("Puoi considerare: \(suggestedAction)")
                        .font(PeakLiftTypography.callout)
                        .foregroundStyle(.primary)
                }
            }
        }
        .accessibilityElement(children: .combine)
    }
}
