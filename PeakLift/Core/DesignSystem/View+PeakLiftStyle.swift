//
//  View+PeakLiftStyle.swift
//  PeakLift
//

import SwiftUI

extension View {
    func peakLiftPageBackground() -> some View {
        background(PeakLiftColor.background.ignoresSafeArea())
    }

    @ViewBuilder
    func peakLiftGlass(tint: Color? = nil, cornerRadius: CGFloat = PeakLiftRadius.lg) -> some View {
        if #available(iOS 26.0, *) {
            if let tint {
                glassEffect(.regular.tint(tint), in: RoundedRectangle(cornerRadius: cornerRadius))
            } else {
                glassEffect(.regular, in: RoundedRectangle(cornerRadius: cornerRadius))
            }
        } else {
            background(.regularMaterial, in: RoundedRectangle(cornerRadius: cornerRadius))
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(PeakLiftColor.separator.opacity(0.6), lineWidth: 1)
                }
        }
    }
}
