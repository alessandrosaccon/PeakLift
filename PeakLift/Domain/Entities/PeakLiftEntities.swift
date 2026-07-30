//
//  PeakLiftEntities.swift
//  PeakLift
//

import Foundation

// Dates are absolute instants. Persistence and transport layers must encode them in UTC.

struct UserProfile: DomainEntity, Codable {
    let id: UUID
    var displayName: String?
    var weightUnit: WeightUnit
    var experienceLevel: ExperienceLevel
    var primaryGoal: PrimaryGoal
    var desiredWeeklyFrequency: Int?
    var preferredLanguage: String
    var onboardingCompleted: Bool
    var syncStatus: SyncStatus
    let createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        displayName: String? = nil,
        weightUnit: WeightUnit,
        experienceLevel: ExperienceLevel,
        primaryGoal: PrimaryGoal,
        desiredWeeklyFrequency: Int? = nil,
        preferredLanguage: String,
        onboardingCompleted: Bool = false,
        syncStatus: SyncStatus = .localOnly,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.displayName = displayName
        self.weightUnit = weightUnit
        self.experienceLevel = experienceLevel
        self.primaryGoal = primaryGoal
        self.desiredWeeklyFrequency = desiredWeeklyFrequency
        self.preferredLanguage = preferredLanguage
        self.onboardingCompleted = onboardingCompleted
        self.syncStatus = syncStatus
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

struct Exercise: DomainEntity, Codable {
    let id: UUID
    var ownerUserID: UUID?
    var name: String
    var normalizedName: String
    var isCustom: Bool
    var equipmentType: EquipmentType
    var movementPattern: MovementPattern?
    var instructions: String?
    var notes: String?
    var isArchived: Bool
    let createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        ownerUserID: UUID? = nil,
        name: String,
        normalizedName: String,
        isCustom: Bool,
        equipmentType: EquipmentType,
        movementPattern: MovementPattern? = nil,
        instructions: String? = nil,
        notes: String? = nil,
        isArchived: Bool = false,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.ownerUserID = ownerUserID
        self.name = name
        self.normalizedName = normalizedName
        self.isCustom = isCustom
        self.equipmentType = equipmentType
        self.movementPattern = movementPattern
        self.instructions = instructions
        self.notes = notes
        self.isArchived = isArchived
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

struct MuscleGroup: DomainEntity, Codable {
    let id: UUID
    var code: String
    var displayName: String
    var bodyRegion: String
    var isSystemDefined: Bool
    let createdAt: Date

    init(id: UUID = UUID(), code: String, displayName: String, bodyRegion: String, isSystemDefined: Bool = true, createdAt: Date = .now) {
        self.id = id
        self.code = code
        self.displayName = displayName
        self.bodyRegion = bodyRegion
        self.isSystemDefined = isSystemDefined
        self.createdAt = createdAt
    }
}

struct ExerciseMuscleGroup: DomainEntity, Codable {
    let id: UUID
    let exerciseID: UUID
    let muscleGroupID: UUID
    var role: MuscleRole
    var contributionWeight: Double
    let createdAt: Date

    init(id: UUID = UUID(), exerciseID: UUID, muscleGroupID: UUID, role: MuscleRole, contributionWeight: Double, createdAt: Date = .now) {
        self.id = id
        self.exerciseID = exerciseID
        self.muscleGroupID = muscleGroupID
        self.role = role
        self.contributionWeight = contributionWeight
        self.createdAt = createdAt
    }
}

struct WorkoutSet: DomainEntity, Codable {
    let id: UUID
    var setOrder: Int
    var weightKg: Double
    var repetitions: Int
    var rpe: Double?
    var rir: Double?
    var setType: SetType
    var status: SetStatus
    var completedAt: Date?
    var restDurationSeconds: Int?
    var notes: String?
    let createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        setOrder: Int,
        weightKg: Double,
        repetitions: Int,
        rpe: Double? = nil,
        rir: Double? = nil,
        setType: SetType = .working,
        status: SetStatus = .planned,
        completedAt: Date? = nil,
        restDurationSeconds: Int? = nil,
        notes: String? = nil,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) throws {
        guard weightKg.isFinite, weightKg >= 0 else { throw DomainValidationError.invalidWeightKg }
        guard repetitions >= 0 else { throw DomainValidationError.invalidRepetitions }
        if let rpe, (!rpe.isFinite || !(1...10).contains(rpe)) { throw DomainValidationError.invalidRPE }
        if let rir, (!rir.isFinite || rir < 0) { throw DomainValidationError.invalidRIR }

        self.id = id
        self.setOrder = setOrder
        self.weightKg = weightKg
        self.repetitions = repetitions
        self.rpe = rpe
        self.rir = rir
        self.setType = setType
        self.status = status
        self.completedAt = completedAt
        self.restDurationSeconds = restDurationSeconds
        self.notes = notes
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    var volumeKg: Double {
        status == .completed ? weightKg * Double(repetitions) : 0
    }

    var contributesToWorkingSetCount: Bool {
        guard status == .completed else { return false }
        return setType == .working || setType == .drop || setType == .failure
    }
}

struct WorkoutExercise: DomainEntity, Codable {
    let id: UUID
    let exerciseID: UUID
    var exerciseNameSnapshot: String
    var displayOrder: Int
    var notes: String?
    var sets: [WorkoutSet]
    let createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        exerciseID: UUID,
        exerciseNameSnapshot: String,
        displayOrder: Int,
        notes: String? = nil,
        sets: [WorkoutSet] = [],
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.exerciseID = exerciseID
        self.exerciseNameSnapshot = exerciseNameSnapshot
        self.displayOrder = displayOrder
        self.notes = notes
        self.sets = sets
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

struct Workout: DomainEntity, Codable {
    let id: UUID
    let userID: UUID
    var title: String?
    var status: WorkoutStatus
    var startedAt: Date
    var completedAt: Date?
    var notes: String?
    var perceivedEffort: Double?
    var source: String
    var exercises: [WorkoutExercise]
    var syncStatus: SyncStatus
    let createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        userID: UUID,
        title: String? = nil,
        status: WorkoutStatus = .draft,
        startedAt: Date = .now,
        completedAt: Date? = nil,
        notes: String? = nil,
        perceivedEffort: Double? = nil,
        source: String = "manual",
        exercises: [WorkoutExercise] = [],
        syncStatus: SyncStatus = .localOnly,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.userID = userID
        self.title = title
        self.status = status
        self.startedAt = startedAt
        self.completedAt = completedAt
        self.notes = notes
        self.perceivedEffort = perceivedEffort
        self.source = source
        self.exercises = exercises
        self.syncStatus = syncStatus
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    var allSets: [WorkoutSet] { exercises.flatMap(\.sets) }
    var totalVolumeKg: Double { allSets.reduce(0) { $0 + $1.volumeKg } }
    var workingSetCount: Int { allSets.filter(\.contributesToWorkingSetCount).count }
}

struct PersonalRecord: DomainEntity, Codable {
    let id: UUID
    let userID: UUID
    let exerciseID: UUID
    var recordType: PersonalRecordType
    var value: Double
    var unit: String
    var achievedAt: Date
    let workoutID: UUID
    var workoutSetID: UUID?
    let createdAt: Date
    var updatedAt: Date

    init(id: UUID = UUID(), userID: UUID, exerciseID: UUID, recordType: PersonalRecordType, value: Double, unit: String, achievedAt: Date, workoutID: UUID, workoutSetID: UUID? = nil, createdAt: Date = .now, updatedAt: Date = .now) {
        self.id = id; self.userID = userID; self.exerciseID = exerciseID; self.recordType = recordType; self.value = value; self.unit = unit; self.achievedAt = achievedAt; self.workoutID = workoutID; self.workoutSetID = workoutSetID; self.createdAt = createdAt; self.updatedAt = updatedAt
    }
}

struct ProgressMetric: DomainEntity, Codable {
    let id: UUID
    let userID: UUID
    var metricType: ProgressMetricType
    var dimension: ProgressMetricDimension
    var dimensionID: UUID?
    var periodStart: Date
    var periodEnd: Date
    var value: Double
    var comparisonValue: Double?
    var unit: String
    var sampleSize: Int
    var confidence: InsightConfidence
    var calculationVersion: Int
    var computedAt: Date
    var expiresAt: Date?

    init(id: UUID = UUID(), userID: UUID, metricType: ProgressMetricType, dimension: ProgressMetricDimension, dimensionID: UUID? = nil, periodStart: Date, periodEnd: Date, value: Double, comparisonValue: Double? = nil, unit: String, sampleSize: Int, confidence: InsightConfidence, calculationVersion: Int, computedAt: Date = .now, expiresAt: Date? = nil) {
        self.id = id; self.userID = userID; self.metricType = metricType; self.dimension = dimension; self.dimensionID = dimensionID; self.periodStart = periodStart; self.periodEnd = periodEnd; self.value = value; self.comparisonValue = comparisonValue; self.unit = unit; self.sampleSize = sampleSize; self.confidence = confidence; self.calculationVersion = calculationVersion; self.computedAt = computedAt; self.expiresAt = expiresAt
    }
}

struct ConsentRecord: DomainEntity, Codable {
    let id: UUID
    let userID: UUID
    var consentType: ConsentType
    var status: ConsentStatus
    var policyVersion: String
    var grantedAt: Date?
    var revokedAt: Date?
    var updatedAt: Date

    init(id: UUID = UUID(), userID: UUID, consentType: ConsentType, status: ConsentStatus, policyVersion: String, grantedAt: Date? = nil, revokedAt: Date? = nil, updatedAt: Date = .now) {
        self.id = id; self.userID = userID; self.consentType = consentType; self.status = status; self.policyVersion = policyVersion; self.grantedAt = grantedAt; self.revokedAt = revokedAt; self.updatedAt = updatedAt
    }
}
