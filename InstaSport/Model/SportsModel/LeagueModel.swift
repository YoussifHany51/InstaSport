//
//  FootBallModel.swift
//  InstaSport
//
//  Created by zyad Baset on 12/08/2024.
//

import Foundation

struct FootBallResult: Codable , SportsProtocol{
    let success: Int
    let result: [FootBallModel]
}

// MARK: - Result
struct FootBallModel: Codable, SportsProtocol {
    let leagueKey: Int
    let leagueName: String
    let countryKey: Int
    let countryName: String
    let leagueLogo, countryLogo: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
    }
}
