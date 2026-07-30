//
//  PeakLiftNavigation.swift
//  PeakLift
//

import SwiftUI

struct PeakLiftNavigationHeader<Trailing: View>: View {
    let title: String
    @ViewBuilder let trailing: Trailing

    init(title: String, @ViewBuilder trailing: () -> Trailing) {
        self.title = title
        self.trailing = trailing()
    }

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: PeakLiftSpacing.x3) {
            Text(title).font(PeakLiftTypography.largeTitle)
            Spacer()
            trailing
        }
        .padding(.horizontal, PeakLiftSpacing.x6)
        .padding(.vertical, PeakLiftSpacing.x3)
        .accessibilityAddTraits(.isHeader)
    }
}

struct PeakLiftSectionHeader: View {
    let title: String
    let actionTitle: String?
    let action: (() -> Void)?

    var body: some View {
        HStack {
            Text(title).font(PeakLiftTypography.title3)
            Spacer()
            if let actionTitle, let action {
                Button(actionTitle, action: action)
                    .font(PeakLiftTypography.subheadline.weight(.semibold))
                    .foregroundStyle(PeakLiftColor.primary)
            }
        }
        .accessibilityElement(children: .contain)
    }
}
