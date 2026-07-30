//
//  FoundationComponents.swift
//  PeakLift
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let systemImage: String?
    let action: () -> Void

    init(_ title: String, systemImage: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.systemImage = systemImage
        self.action = action
    }

    var body: some View {
        PeakLiftButton(title, systemImage: systemImage, style: .primary, action: action)
    }
}

struct SecondaryButton: View {
    let title: String
    let systemImage: String?
    let action: () -> Void

    init(_ title: String, systemImage: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.systemImage = systemImage
        self.action = action
    }

    var body: some View {
        PeakLiftButton(title, systemImage: systemImage, style: .secondary, action: action)
    }
}

struct DestructiveButton: View {
    let title: String
    let systemImage: String?
    let action: () -> Void

    init(_ title: String, systemImage: String? = "trash", action: @escaping () -> Void) {
        self.title = title
        self.systemImage = systemImage
        self.action = action
    }

    var body: some View {
        PeakLiftButton(title, systemImage: systemImage, style: .destructive, action: action)
    }
}

struct IconButton: View {
    let systemImage: String
    let accessibilityLabel: String
    let action: () -> Void

    var body: some View {
        PeakLiftIconButton(
            systemImage: systemImage,
            accessibilityLabel: accessibilityLabel,
            action: action
        )
    }
}

struct EmptyStateView: View {
    let title: String
    let message: String
    let systemImage: String

    var body: some View {
        ContentUnavailableView {
            Label(title, systemImage: systemImage)
        } description: {
            Text(message)
        }
        .foregroundStyle(.primary)
        .accessibilityElement(children: .combine)
    }
}

struct LoadingStateView: View {
    let title: String

    init(title: String = "Caricamento") {
        self.title = title
    }

    var body: some View {
        VStack(spacing: PeakLiftSpacing.x3) {
            ProgressView()
                .tint(PeakLiftColor.primary)
            Text(title)
                .font(PeakLiftTypography.callout)
                .foregroundStyle(.secondary)
        }
        .padding(PeakLiftSpacing.x6)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(title)
    }
}

struct ErrorStateView: View {
    let title: String
    let message: String
    let retryTitle: String?
    let retryAction: (() -> Void)?

    init(
        title: String = "Qualcosa non ha funzionato",
        message: String,
        retryTitle: String? = nil,
        retryAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.retryTitle = retryTitle
        self.retryAction = retryAction
    }

    var body: some View {
        VStack(spacing: PeakLiftSpacing.x3) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.title2)
                .foregroundStyle(PeakLiftColor.error)
            Text(title).font(PeakLiftTypography.title3)
            Text(message)
                .font(PeakLiftTypography.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            if let retryTitle, let retryAction {
                SecondaryButton(retryTitle, systemImage: "arrow.clockwise", action: retryAction)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(PeakLiftSpacing.x6)
        .background(PeakLiftColor.errorSoft, in: RoundedRectangle(cornerRadius: PeakLiftRadius.lg))
        .accessibilityElement(children: .contain)
    }
}

struct SectionHeader: View {
    let title: String
    let actionTitle: String?
    let action: (() -> Void)?

    init(title: String, actionTitle: String? = nil, action: (() -> Void)? = nil) {
        self.title = title
        self.actionTitle = actionTitle
        self.action = action
    }

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: PeakLiftSpacing.x3) {
            Text(title)
                .font(PeakLiftTypography.title3)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            if let actionTitle, let action {
                Button(actionTitle, action: action)
                    .font(PeakLiftTypography.subheadline.weight(.semibold))
                    .foregroundStyle(PeakLiftColor.primary)
                    .frame(minHeight: 44)
            }
        }
    }
}

struct MetricLabel: View {
    let title: String
    let value: String
    let unit: String?

    init(title: String, value: String, unit: String? = nil) {
        self.title = title
        self.value = value
        self.unit = unit
    }

    var body: some View {
        VStack(alignment: .leading, spacing: PeakLiftSpacing.x1) {
            Text(title)
                .font(PeakLiftTypography.caption)
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
        }
        .accessibilityElement(children: .combine)
    }
}
