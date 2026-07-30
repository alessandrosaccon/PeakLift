//
//  ProgressRing.swift
//  PeakLift
//

import SwiftUI

struct ProgressRing: View {
    let title: String
    let current: Int
    let target: Int
    let tint: Color

    init(title: String, current: Int, target: Int, tint: Color = PeakLiftColor.primary) {
        self.title = title
        self.current = current
        self.target = max(target, 1)
        self.tint = tint
    }

    private var progress: Double { min(Double(current) / Double(target), 1) }

    var body: some View {
        VStack(spacing: PeakLiftSpacing.x2) {
            ZStack {
                Circle().stroke(PeakLiftColor.separator, lineWidth: 8)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(tint, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Text("\(Int(progress * 100))%")
                    .font(PeakLiftTypography.metricSmall)
                    .monospacedDigit()
            }
            .frame(width: 112, height: 112)
            Text(title).font(PeakLiftTypography.subheadline)
            Text("\(current) di \(target)").font(PeakLiftTypography.caption).foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(title), \(current) su \(target), \(Int(progress * 100)) percento")
    }
}
