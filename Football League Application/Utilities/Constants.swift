//
//  Constants.swift
//  Football League Application
//
//  Created by mariam adly on 02/07/2024.
//

import Foundation

struct Constants {
    static let baseURL = "https://api.football-data.org/v4"
    
    struct Endpoints {
        static let competitions = "/competitions"
        static func competitionsDetails(competitionID: Int) -> String {
            return "/competitions/\(competitionID)"
        }
        static func teams(competitionID: Int) -> String {
            return "/competitions/\(competitionID)/teams"
        }
    }
}
