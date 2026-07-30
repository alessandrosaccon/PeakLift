//
//  PeakLiftTokens.swift
//  PeakLift
//

import SwiftUI

enum PeakLiftSpacing {
    static let x1: CGFloat = 4
    static let x2: CGFloat = 8
    static let x3: CGFloat = 12
    static let x4: CGFloat = 16
    static let x5: CGFloat = 20
    static let x6: CGFloat = 24
    static let x7: CGFloat = 32
    static let x8: CGFloat = 40
    static let x9: CGFloat = 48
    static let x10: CGFloat = 64
}

enum PeakLiftRadius {
    static let xs: CGFloat = 8
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 20
    static let xl: CGFloat = 24
    static let pill: CGFloat = 999
}

enum PeakLiftTypography {
    static let heroMetric = Font.system(size: 40, weight: .bold, design: .rounded)
    static let largeTitle = Font.largeTitle.weight(.bold)
    static let title1 = Font.title.weight(.semibold)
    static let title2 = Font.title2.weight(.semibold)
    static let title3 = Font.title3.weight(.semibold)
    static let headline = Font.headline
    static let body = Font.body
    static let bodyEmphasis = Font.body.weight(.medium)
    static let callout = Font.callout
    static let subheadline = Font.subheadline
    static let footnote = Font.footnote
    static let caption = Font.caption.weight(.medium)
    static let metricSmall = Font.system(size: 20, weight: .semibold, design: .rounded)
    static let metricMedium = Font.system(size: 28, weight: .bold, design: .rounded)
}

enum PeakLiftMotion {
    static let instant = Animation.easeOut(duration: 0.1)
    static let fast = Animation.easeInOut(duration: 0.18)
    static let standard = Animation.spring(response: 0.25, dampingFraction: 0.85)
    static let emphasis = Animation.spring(response: 0.35, dampingFraction: 0.88)
}
