//
//  Competitions.swift
//  Football League Application
//
//  Created by mariam adly on 01/07/2024.
//

import Foundation
struct CompetitionResult: Codable {
    let count: Int
    let filters: Filters
    let competitions: [Competition]
}

// MARK: - Competition
struct Competition: Codable {
    let id: Int
    let area: Area
    let name: String
    let code: String?
    let type: TypeEnum
    let emblem: String?
    let plan: Plan
    let currentSeason: CurrentSeason?
    let numberOfAvailableSeasons: Int
    let lastUpdated: String
}

// MARK: - Area
struct Area: Codable {
    let id: Int
    let name, code: String
    let flag: String?
}

// MARK: - CurrentSeason
struct CurrentSeason: Codable {
    let id: Int
    let startDate, endDate: String
    let currentMatchday: Int?
    let winner: Winner?
}

// MARK: - Winner
struct Winner: Codable {
    let id: Int
    let name: String
    let shortName, tla: String?
    let crest: String?
    let address: String
    let website: String?
    let founded: Int?
    let clubColors, venue: String?
    let lastUpdated: String
}

enum Plan: String, Codable {
    case tierFour = "TIER_FOUR"
    case tierOne = "TIER_ONE"
    case tierThree = "TIER_THREE"
    case tierTwo = "TIER_TWO"
}

enum TypeEnum: String, Codable {
    case cup = "CUP"
    case league = "LEAGUE"
    case playoffs = "PLAYOFFS"
    case superCup = "SUPER_CUP"
}

// MARK: - Filters
struct Filters: Codable {
}
