//
//  CoachModel.swift
//  InstaSport
//
//  Created by zyad Baset on 14/08/2024.
//

import Foundation
struct Coach: Codable {
    let coachName: String

    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
    }
}
