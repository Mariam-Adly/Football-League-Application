//
//  CompetitionDetailsResult.swift
//  Football League Application
//
//  Created by mariam adly on 02/07/2024.
//

import Foundation

struct CompetitionDetails: Codable {
    let area: Area
    let id: Int
    let name, code, type: String
    let emblem: String
    let currentSeason: Season
    let seasons: [Season]
    let lastUpdated: String
}


// MARK: - Season
struct Season: Codable {
    let id: Int
    let startDate, endDate: String
    let currentMatchday: Int?
    let winner: Winner?
}

