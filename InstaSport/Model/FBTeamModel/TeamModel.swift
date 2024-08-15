//
//  TeamModel.swift
//  InstaSport
//
//  Created by zyad Baset on 14/08/2024.
//

import Foundation
struct TeamModel: Codable {
    let teamKey: Int
    let teamName: String
    let teamLogo: String
    let players: [Player]
    let coaches: [Coach]

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players, coaches
    }
}

