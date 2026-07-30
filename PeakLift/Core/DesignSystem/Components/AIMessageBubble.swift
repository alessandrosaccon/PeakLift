//
//  AIMessageBubble.swift
//  PeakLift
//

import SwiftUI

enum AIMessageSender { case user, coach, system, safety }

struct AIMessageBubble: View {
    let sender: AIMessageSender
    let message: String
    let period: String?

    var body: some View {
        HStack {
            if sender == .user { Spacer(minLength: PeakLiftSpacing.x8) }
            VStack(alignment: .leading, spacing: PeakLiftSpacing.x2) {
                Text(senderLabel).font(PeakLiftTypography.caption).foregroundStyle(.secondary)
                Text(message).font(PeakLiftTypography.body)
                if let period {
                    Text(period).font(PeakLiftTypography.caption).foregroundStyle(.secondary)
                }
            }
            .padding(PeakLiftSpacing.x4)
            .background(background, in: RoundedRectangle(cornerRadius: PeakLiftRadius.lg))
            if sender != .user { Spacer(minLength: PeakLiftSpacing.x8) }
        }
        .accessibilityElement(children: .combine)
    }

    private var senderLabel: String {
        switch sender {
        case .user: "Tu"
        case .coach: "Coach"
        case .system: "Sistema"
        case .safety: "Avviso"
        }
    }

    private var background: Color {
        switch sender {
        case .user: PeakLiftColor.primarySoft
        case .coach: PeakLiftColor.surface
        case .system: PeakLiftColor.surfaceSubtle
        case .safety: PeakLiftColor.warningSoft
        }
    }
}
