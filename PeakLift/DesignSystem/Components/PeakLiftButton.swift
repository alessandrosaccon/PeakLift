//
//  PeakLiftButton.swift
//  PeakLift
//

import SwiftUI

enum PeakLiftButtonStyle {
    case primary
    case secondary
    case destructive
}

struct PeakLiftButton: View {
    let title: String
    let systemImage: String?
    let style: PeakLiftButtonStyle
    let action: () -> Void

    init(_ title: String, systemImage: String? = nil, style: PeakLiftButtonStyle = .primary, action: @escaping () -> Void) {
        self.title = title
        self.systemImage = systemImage
        self.style = style
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Label {
                Text(title)
            } icon: {
                if let systemImage {
                    Image(systemName: systemImage)
                }
            }
            .font(PeakLiftTypography.headline)
            .frame(maxWidth: .infinity, minHeight: 52)
        }
        .buttonStyle(PeakLiftButtonPressStyle(style: style))
        .accessibilityHint(title)
    }
}

struct PeakLiftIconButton: View {
    let systemImage: String
    let accessibilityLabel: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.body.weight(.semibold))
                .frame(width: 44, height: 44)
        }
        .buttonStyle(.plain)
        .foregroundStyle(PeakLiftColor.primary)
        .background(PeakLiftColor.primarySoft, in: Circle())
        .accessibilityLabel(accessibilityLabel)
    }
}

private struct PeakLiftButtonPressStyle: ButtonStyle {
    let style: PeakLiftButtonStyle

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(foreground)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: PeakLiftRadius.lg))
            .overlay {
                if style == .secondary {
                    RoundedRectangle(cornerRadius: PeakLiftRadius.lg)
                        .stroke(PeakLiftColor.separator, lineWidth: 1)
                }
            }
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .opacity(configuration.isPressed ? 0.86 : 1)
            .animation(PeakLiftMotion.instant, value: configuration.isPressed)
    }

    private var foreground: Color {
        switch style {
        case .primary: PeakLiftColor.primaryOn
        case .secondary: PeakLiftColor.primary
        case .destructive: PeakLiftColor.error
        }
    }

    private var background: Color {
        switch style {
        case .primary: PeakLiftColor.primary
        case .secondary: PeakLiftColor.primarySoft
        case .destructive: PeakLiftColor.errorSoft
        }
    }
}
