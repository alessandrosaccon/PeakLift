//
//  PeakLiftColor.swift
//  PeakLift
//

import SwiftUI
import UIKit

enum PeakLiftColor {
    static let primary = Color(light: 0x0B6E69, dark: 0x5EEAD4)
    static let primaryStrong = Color(light: 0x075A56, dark: 0x99F6E4)
    static let primarySoft = Color(light: 0xD7F5F1, dark: 0x123D3A)
    static let primaryOn = Color(light: 0xFFFFFF, dark: 0x082321)

    static let secondary = Color(light: 0x4361EE, dark: 0x8EA2FF)
    static let secondarySoft = Color(light: 0xE8ECFF, dark: 0x202B5A)
    static let accentWarm = Color(light: 0xF59E0B, dark: 0xFBBF24)
    static let accentViolet = Color(light: 0x7C3AED, dark: 0xC4B5FD)

    static let background = Color(light: 0xF5F7F8, dark: 0x0A0D10)
    static let backgroundElevated = Color(light: 0xFFFFFF, dark: 0x10151A)
    static let backgroundGrouped = Color(light: 0xEEF1F3, dark: 0x151B21)
    static let backgroundWorkout = Color(light: 0xF8FAFA, dark: 0x080B0D)
    static let surface = Color(light: 0xFFFFFF, dark: 0x151A20)
    static let surfaceSubtle = Color(light: 0xF8FAFB, dark: 0x1C232B)
    static let surfaceSelected = Color(light: 0xEAF8F6, dark: 0x17312F)
    static let separator = Color(light: 0xD9E0E4, dark: 0x2A343E)

    static let success = Color(light: 0x16803C, dark: 0x4ADE80)
    static let successSoft = Color(light: 0xE4F7EA, dark: 0x173D27)
    static let warning = Color(light: 0xB45309, dark: 0xFBBF24)
    static let warningSoft = Color(light: 0xFFF4DC, dark: 0x4A3514)
    static let error = Color(light: 0xC12B32, dark: 0xFF8A8E)
    static let errorSoft = Color(light: 0xFDE8E8, dark: 0x4A2023)
    static let info = Color(light: 0x2563B8, dark: 0x7DB5FF)
}

private extension Color {
    init(light: UInt, dark: UInt) {
        self.init(uiColor: UIColor { traits in
            UIColor(hex: traits.userInterfaceStyle == .dark ? dark : light)
        })
    }
}

private extension UIColor {
    convenience init(hex: UInt) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1
        )
    }
}
