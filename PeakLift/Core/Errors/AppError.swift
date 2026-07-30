//
//  AppError.swift
//  PeakLift
//

import Foundation

enum AppError: LocalizedError {
    case unavailable

    var errorDescription: String? {
        "This capability is not available yet."
    }
}
