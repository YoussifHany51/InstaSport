//
//  BasketBallModel.swift
//  InstaSport
//
//  Created by zyad Baset on 12/08/2024.
//

import Foundation

struct BasketBallResult: Codable , SportsProtocol{
    let success: Int
    let result: [BasketBallModel]
}

// MARK: - Result
struct BasketBallModel: Codable , SportsProtocol{
    let leagueKey: Int
    let leagueName: String
    let countryKey: Int
    let countryName: String

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
    }
}
