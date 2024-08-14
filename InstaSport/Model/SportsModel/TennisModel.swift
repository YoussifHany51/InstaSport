//
//  TennisModel.swift
//  InstaSport
//
//  Created by zyad Baset on 12/08/2024.
//
import Foundation

// MARK: - Tennis
struct TennisResult: Codable, SportsProtocol {
    let success: Int
    let result: [TennisModel]
}

// MARK: - Result
struct TennisModel: Codable, SportsProtocol {
    let leagueKey: Int
    let leagueName: String
    let countryKey: Int
    let countryName: CountryName

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
    }
}

enum CountryName: String, Codable {
    case atpDoubles = "Atp Doubles"
    case atpSingles = "Atp Singles"
    case boysDoubles = "Boys Doubles"
    case boysSingles = "Boys Singles"
    case challengerMenDoubles = "Challenger Men Doubles"
    case challengerMenSingles = "Challenger Men Singles"
    case challengerWomenDoubles = "Challenger Women Doubles"
    case challengerWomenSingles = "Challenger Women Singles"
    case exhibitionDoublesMen = "Exhibition Doubles Men"
    case exhibitionDoublesWomen = "Exhibition Doubles Women"
    case exhibitionMen = "Exhibition Men"
    case exhibitionMixedDoubles = "Exhibition Mixed Doubles"
    case exhibitionTeams = "Exhibition Teams"
    case exhibitionWomen = "Exhibition Women"
    case girlsDoubles = "Girls Doubles"
    case girlsSingles = "Girls Singles"
    case itfMenDoubles = "Itf Men Doubles"
    case itfMenSingles = "Itf Men Singles"
    case itfWomenDoubles = "Itf Women Doubles"
    case itfWomenSingles = "Itf Women Singles"
    case mixedDoubles = "Mixed Doubles"
    case teamsMen = "Teams Men"
    case teamsMix = "Teams Mix"
    case teamsWomen = "Teams Women"
    case wtaDoubles = "Wta Doubles"
    case wtaSingles = "Wta Singles"
}
