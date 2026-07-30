//
//  DomainValidationError.swift
//  PeakLift
//

import Foundation

enum DomainValidationError: Error, Equatable, Sendable {
    case invalidWeightKg
    case invalidRepetitions
    case invalidRPE
    case invalidRIR
}
