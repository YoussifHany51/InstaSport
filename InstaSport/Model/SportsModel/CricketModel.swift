//
//  CricketModel.swift
//  InstaSport
//
//  Created by zyad Baset on 12/08/2024.
//

import Foundation

struct CricketResult: Codable, SportsProtocol {
    let success: Int
    let result: [CricketModel]
}

// MARK: - Result
struct CricketModel: Codable, SportsProtocol {
    let leagueKey: Int
    let leagueName, leagueYear: String

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case leagueYear = "league_year"
    }
}
