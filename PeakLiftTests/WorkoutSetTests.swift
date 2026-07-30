import XCTest
@testable import PeakLift

final class WorkoutSetTests: XCTestCase {
    func testStableClientGeneratedIdentifierIsPreserved() throws {
        let id = UUID()
        let set = try makeSet(id: id)
        XCTAssertEqual(set.id, id)
    }

    func testNegativeWeightIsRejected() {
        XCTAssertThrowsError(try makeSet(weightKg: -0.1)) { XCTAssertEqual($0 as? DomainValidationError, .invalidWeightKg) }
    }

    func testNegativeRepetitionsAreRejected() {
        XCTAssertThrowsError(try makeSet(repetitions: -1)) { XCTAssertEqual($0 as? DomainValidationError, .invalidRepetitions) }
    }

    func testRPEMustBeWithinOneToTen() {
        XCTAssertThrowsError(try makeSet(rpe: 0.9)) { XCTAssertEqual($0 as? DomainValidationError, .invalidRPE) }
        XCTAssertThrowsError(try makeSet(rpe: 10.1)) { XCTAssertEqual($0 as? DomainValidationError, .invalidRPE) }
        XCTAssertNoThrow(try makeSet(rpe: 7.5))
    }

    func testRIRCannotBeNegative() {
        XCTAssertThrowsError(try makeSet(rir: -0.5)) { XCTAssertEqual($0 as? DomainValidationError, .invalidRIR) }
        XCTAssertNoThrow(try makeSet(rir: 0))
    }

    func testSkippedSetDoesNotContributeVolumeOrWorkingSets() throws {
        let set = try makeSet(status: .skipped)
        XCTAssertEqual(set.volumeKg, 0)
        XCTAssertFalse(set.contributesToWorkingSetCount)
    }

    func testWarmupIsIncludedInCompletedVolumeButNotWorkingSetCount() throws {
        let warmup = try makeSet(weightKg: 20, repetitions: 10, setType: .warmup, status: .completed)
        XCTAssertEqual(warmup.volumeKg, 200)
        XCTAssertFalse(warmup.contributesToWorkingSetCount)
    }

    func testWorkoutCalculatesCompletedVolumeAndWorkingSetCount() throws {
        let warmup = try makeSet(weightKg: 20, repetitions: 10, setType: .warmup, status: .completed)
        let working = try makeSet(weightKg: 80, repetitions: 8, setType: .working, status: .completed)
        let drop = try makeSet(weightKg: 60, repetitions: 12, setType: .drop, status: .completed)
        let skipped = try makeSet(weightKg: 100, repetitions: 5, setType: .working, status: .skipped)
        let exercise = WorkoutExercise(exerciseID: UUID(), exerciseNameSnapshot: "Bench press", displayOrder: 0, sets: [warmup, working, drop, skipped])
        let workout = Workout(userID: UUID(), exercises: [exercise])

        XCTAssertEqual(workout.totalVolumeKg, 1_560)
        XCTAssertEqual(workout.workingSetCount, 2)
    }

    private func makeSet(
        id: UUID = UUID(),
        weightKg: Double = 80,
        repetitions: Int = 8,
        rpe: Double? = nil,
        rir: Double? = nil,
        setType: SetType = .working,
        status: SetStatus = .planned
    ) throws -> WorkoutSet {
        try WorkoutSet(id: id, setOrder: 1, weightKg: weightKg, repetitions: repetitions, rpe: rpe, rir: rir, setType: setType, status: status)
    }
}
