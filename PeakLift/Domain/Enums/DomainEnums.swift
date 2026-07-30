//
//  DomainEnums.swift
//  PeakLift
//

import Foundation

enum WeightUnit: String, CaseIterable, Codable, Sendable { case kg, lb }
enum ExperienceLevel: String, CaseIterable, Codable, Sendable { case beginner, intermediate, advanced }
enum PrimaryGoal: String, CaseIterable, Codable, Sendable { case strength, hypertrophy, recomposition, generalFitness }
enum WorkoutStatus: String, CaseIterable, Codable, Sendable { case draft, inProgress, completed, cancelled }
enum SetStatus: String, CaseIterable, Codable, Sendable { case planned, completed, skipped }
enum SetType: String, CaseIterable, Codable, Sendable { case warmup, working, drop, failure, custom }
enum EquipmentType: String, CaseIterable, Codable, Sendable { case barbell, dumbbell, cable, machine, bodyweight, other }
enum MovementPattern: String, CaseIterable, Codable, Sendable { case push, pull, squat, hinge, carry, isolation, other }
enum MuscleRole: String, CaseIterable, Codable, Sendable { case primary, secondary }
enum SyncStatus: String, CaseIterable, Codable, Sendable { case localOnly, pendingUpload, synced, conflict, failed }
enum ConsentType: String, CaseIterable, Codable, Sendable { case ai, healthKit, analytics, notifications }
enum ConsentStatus: String, CaseIterable, Codable, Sendable { case granted, denied, revoked }
enum InsightCategory: String, CaseIterable, Codable, Sendable { case progression, volume, frequency, balance, consistency, recovery, insufficientData }
enum InsightConfidence: String, CaseIterable, Codable, Sendable { case low, medium, high, insufficient }

enum PersonalRecordType: String, CaseIterable, Codable, Sendable { case maxWeight, maxReps, maxVolume, estimatedOneRepMax }
enum ProgressMetricType: String, CaseIterable, Codable, Sendable { case volume, frequency, estimatedOneRepMax, workingSets, streak, balance }
enum ProgressMetricDimension: String, CaseIterable, Codable, Sendable { case global, exercise, muscleGroup }
