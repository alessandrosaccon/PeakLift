//
//  AppLogger.swift
//  PeakLift
//

import OSLog

enum AppLogger {
    static let app = Logger(subsystem: "AlessandroSaccon.PeakLift", category: "app")
    static let data = Logger(subsystem: "AlessandroSaccon.PeakLift", category: "data")
    static let services = Logger(subsystem: "AlessandroSaccon.PeakLift", category: "services")
}
