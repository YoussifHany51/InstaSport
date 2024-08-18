//
//  PlayerModel.swift
//  InstaSport
//
//  Created by zyad Baset on 14/08/2024.
//

import Foundation

struct Player: Codable {
    let playerKey: Int
    let playerImage: String?
    let playerName, playerNumber: String
    let playerCountry: JSONNull?
    let playerType: PlayerType
    let playerAge: String
    let playerRating: String

    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerImage = "player_image"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerCountry = "player_country"
        case playerType = "player_type"
        case playerAge = "player_age"
        case playerRating = "player_rating"
    }
    
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.playerKey = try container.decode(Int.self, forKey: .playerKey)
        self.playerImage = try container.decodeIfPresent(String.self, forKey: .playerImage)
        self.playerName = try container.decode(String.self, forKey: .playerName)
        self.playerNumber = try container.decode(String.self, forKey: .playerNumber)
        self.playerCountry = try container.decodeIfPresent(JSONNull.self, forKey: .playerCountry)
        self.playerType = try container.decode(PlayerType.self, forKey: .playerType)
        self.playerAge = try container.decode(String.self, forKey: .playerAge)
        self.playerRating = try container.decode(String.self, forKey: .playerRating)
    }
}
