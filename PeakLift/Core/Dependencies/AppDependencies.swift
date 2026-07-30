//
//  AppDependencies.swift
//  PeakLift
//

import Foundation

/// The composition root for runtime services.
///
/// Concrete implementations are intentionally introduced only when their
/// corresponding feature is implemented. The app currently exposes its
/// dependency boundary without starting business services.
struct AppDependencies {
    static let live = AppDependencies()

    private init() {}
}
