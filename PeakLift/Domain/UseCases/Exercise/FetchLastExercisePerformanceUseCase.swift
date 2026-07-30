//
//  FetchLastExercisePerformanceUseCase.swift
//  PeakLift
//

import Foundation

/// Fetches the most recent personal record (any type) for a given exercise.
struct FetchLastExercisePerformanceUseCase: UseCase {
    private let personalRecordRepository: any PersonalRecordRepository

    init(personalRecordRepository: any PersonalRecordRepository) {
        self.personalRecordRepository = personalRecordRepository
    }

    func execute(userID: UUID, exerciseID: UUID) async throws -> PersonalRecord? {
        try await personalRecordRepository.fetchLastPerformance(userID: userID, exerciseID: exerciseID)
    }
}
