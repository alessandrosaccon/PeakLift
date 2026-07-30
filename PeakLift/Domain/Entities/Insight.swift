//
//  Insight.swift
//  PeakLift
//

import Foundation

struct Insight: DomainEntity, Codable {
    let id: UUID
    let userID: UUID
    var category: InsightCategory
    var confidence: InsightConfidence
    var title: String
    var body: String
    var relatedExerciseID: UUID?
    var relatedMuscleGroupID: UUID?
    var isArchived: Bool
    let createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        userID: UUID,
        category: InsightCategory,
        confidence: InsightConfidence,
        title: String,
        body: String,
        relatedExerciseID: UUID? = nil,
        relatedMuscleGroupID: UUID? = nil,
        isArchived: Bool = false,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.userID = userID
        self.category = category
        self.confidence = confidence
        self.title = title
        self.body = body
        self.relatedExerciseID = relatedExerciseID
        self.relatedMuscleGroupID = relatedMuscleGroupID
        self.isArchived = isArchived
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
