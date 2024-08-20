//
//  FootBallModel.swift
//  InstaSport
//
//  Created by zyad Baset on 12/08/2024.
//

import Foundation

struct LeagueResult: Codable{
    let success: Int
    let result: [LeagueModel]
}

// MARK: - Result
struct LeagueModel: Codable {
    var leagueKey: Int
    var leagueName: String
    var leagueLogo: String?
    var leagueUrl: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
        case leagueUrl = "league_url"
    }
    init(league:LeagueCD){
        leagueKey=Int(league.leagueKey)
        leagueName=league.leagueName!
        leagueLogo=league.leagueLogo
        leagueUrl=league.leagueUrl
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.leagueKey = try container.decode(Int.self, forKey: .leagueKey)
        self.leagueName = try container.decode(String.self, forKey: .leagueName)
        self.leagueLogo = try container.decodeIfPresent(String.self, forKey: .leagueLogo)
        self.leagueUrl = "https://www.youtube.com/@\(leagueName)"
    }
    init(leagueKey:Int,leagueName:String,leagueLogo:String,leagueUrl:String){
        self.leagueKey=leagueKey
        self.leagueName=leagueName
        self.leagueLogo=leagueLogo
        self.leagueUrl=leagueUrl
    }
}

extension LeagueModel {
    init(from leagueCD: LeagueCD) {
        self.leagueKey = Int(leagueCD.leagueKey)
        self.leagueName = leagueCD.leagueName ?? ""
        self.leagueLogo = leagueCD.leagueLogo
        self.leagueUrl = leagueCD.leagueUrl
    }
}
