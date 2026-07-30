//
//  Cards.swift
//  PeakLift
//

import SwiftUI

enum GlassCardEmphasis {
    case neutral, primary, ai, success, warning

    var tint: Color? {
        switch self {
        case .neutral: nil
        case .primary: PeakLiftColor.primarySoft
        case .ai: PeakLiftColor.accentViolet.opacity(0.18)
        case .success: PeakLiftColor.successSoft
        case .warning: PeakLiftColor.warningSoft
        }
    }
}

struct GlassCard<Content: View>: View {
    let emphasis: GlassCardEmphasis
    @ViewBuilder let content: Content

    init(emphasis: GlassCardEmphasis = .neutral, @ViewBuilder content: () -> Content) {
        self.emphasis = emphasis
        self.content = content()
    }

    var body: some View {
        content
            .padding(PeakLiftSpacing.x5)
            .peakLiftGlass(tint: emphasis.tint, cornerRadius: PeakLiftRadius.xl)
            .shadow(color: .black.opacity(0.08), radius: 20, y: 8)
    }
}

struct MetricCard: View {
    let title: String
    let value: String
    let unit: String?
    let trend: String?
    let trendDirection: TrendDirection

    enum TrendDirection {
        case positive, negative, neutral

        var symbol: String {
            switch self {
            case .positive: "arrow.up.right"
            case .negative: "arrow.down.right"
            case .neutral: "minus"
            }
        }

        var color: Color {
            switch self {
            case .positive: PeakLiftColor.success
            case .negative: PeakLiftColor.warning
            case .neutral: .secondary
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: PeakLiftSpacing.x3) {
            Text(title)
                .font(PeakLiftTypography.subheadline)
                .foregroundStyle(.secondary)
            HStack(alignment: .firstTextBaseline, spacing: PeakLiftSpacing.x1) {
                Text(value)
                    .font(PeakLiftTypography.metricMedium)
                    .monospacedDigit()
                if let unit {
                    Text(unit)
                        .font(PeakLiftTypography.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            if let trend {
                Label(trend, systemImage: trendDirection.symbol)
                    .font(PeakLiftTypography.caption)
                    .foregroundStyle(trendDirection.color)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(PeakLiftSpacing.x4)
        .background(PeakLiftColor.surface, in: RoundedRectangle(cornerRadius: PeakLiftRadius.lg))
        .overlay {
            RoundedRectangle(cornerRadius: PeakLiftRadius.lg)
                .stroke(PeakLiftColor.separator.opacity(0.8), lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
    }
}

struct ChartCard<ChartContent: View>: View {
    let title: String
    let period: String
    let summary: String
    @ViewBuilder let chartContent: ChartContent

    init(title: String, period: String, summary: String, @ViewBuilder chartContent: () -> ChartContent) {
        self.title = title
        self.period = period
        self.summary = summary
        self.chartContent = chartContent()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: PeakLiftSpacing.x4) {
            HStack(alignment: .firstTextBaseline) {
                Text(title).font(PeakLiftTypography.title3)
                Spacer()
                Text(period).font(PeakLiftTypography.caption).foregroundStyle(.secondary)
            }
            chartContent.frame(minHeight: 180)
            Text(summary).font(PeakLiftTypography.callout).foregroundStyle(.secondary)
        }
        .padding(PeakLiftSpacing.x5)
        .background(PeakLiftColor.surface, in: RoundedRectangle(cornerRadius: PeakLiftRadius.lg))
        .accessibilityElement(children: .combine)
    }
}
