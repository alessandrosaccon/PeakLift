//
//  AppMetadata.swift
//  PeakLift
//

import Foundation
import SwiftData

/// Technical metadata used to initialise the local SwiftData store.
/// Domain entities will be added to this schema in later milestones.
@Model
final class AppMetadata {
    var createdAt: Date

    init(createdAt: Date = .now) {
        self.createdAt = createdAt
    }
}
