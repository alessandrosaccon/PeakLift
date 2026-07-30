//
//  DomainEntity.swift
//  PeakLift
//

import Foundation

protocol DomainEntity: Identifiable, Sendable where ID: Hashable & Sendable {}
