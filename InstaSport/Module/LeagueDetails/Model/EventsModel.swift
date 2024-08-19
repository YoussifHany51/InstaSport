//
//  EventsModel.swift
//  InstaSport
//
//  Created by zyad Baset on 16/08/2024.
//

import Foundation
struct EventResult: Decodable {
    let success: Int
    let result: [EventModel]
}
struct EventModel: Decodable {
    let eventKey: Int
    let homeTeamKey:Int
    let awayTeamKey:Int
    let eventDate, eventTime, eventHomeTeam: String?
    let eventAwayTeam: String?
    let eventHalftimeResult: String?
    let eventFinalResult, eventPenaltyResult: String?
    let countryName : String?
    let eventStadium : String?
    let homeTeamLogo, awayTeamLogo: String?
    
    init() {
        self.eventKey = 0
        self.homeTeamKey = 0
        self.awayTeamKey = 0
        self.eventDate = ""
        self.eventTime = ""
        self.eventHomeTeam = ""
        self.eventAwayTeam = ""
        self.eventHalftimeResult = ""
        self.eventFinalResult = "no Events Record from \(DateOptimizer.oneYearBefore)"
        self.eventPenaltyResult = ""
        self.countryName = ""
        self.eventStadium = "no Events Record from \(DateOptimizer.oneYearBefore)"
        self.homeTeamLogo = "Error"
        self.awayTeamLogo = "Error"
    }
    init(i:Int) {
        self.eventKey = 0
        self.homeTeamKey = 0
        self.awayTeamKey = 0
        self.eventDate = ""
        self.eventTime = "There is no Events untill \(DateOptimizer.oneYearAfter)"
        self.eventHomeTeam = ""
        self.eventAwayTeam = ""
        self.eventHalftimeResult = ""
        self.eventFinalResult = "There is no Events untill \(DateOptimizer.oneYearAfter)"
        self.eventPenaltyResult = ""
        self.countryName = ""
        self.eventStadium = "There is no Events untill \(DateOptimizer.oneYearAfter)"
        self.homeTeamLogo = "Error"
        self.awayTeamLogo = "Error"
    }
    
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eventKey = try container.decode(Int.self, forKey: .eventKey)
        self.eventDate = try container.decodeIfPresent(String.self, forKey: .eventDate)
        self.eventTime = try container.decodeIfPresent(String.self, forKey: .eventTime)
        self.eventHomeTeam = try container.decodeIfPresent(String.self, forKey: .eventHomeTeam)
        self.eventAwayTeam = try container.decodeIfPresent(String.self, forKey: .eventAwayTeam)
        self.eventHalftimeResult = try container.decodeIfPresent(String.self, forKey: .eventHalftimeResult)
        self.eventFinalResult = try container.decodeIfPresent(String.self, forKey: .eventFinalResult)
        self.eventPenaltyResult = try container.decodeIfPresent(String.self, forKey: .eventPenaltyResult)
        self.countryName = try container.decodeIfPresent(String.self, forKey: .countryName)
        self.eventStadium = try container.decodeIfPresent(String.self, forKey: .eventStadium)
        self.homeTeamLogo = try container.decodeIfPresent(String.self, forKey: .homeTeamLogo)
        self.awayTeamLogo = try container.decodeIfPresent(String.self, forKey: .awayTeamLogo)
        self.homeTeamKey = try container.decode(Int.self, forKey: .homeTeamKey)
        self.awayTeamKey = try container.decode(Int.self, forKey: .awayTeamKey)
    }
    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case eventAwayTeam = "event_away_team"
        case eventHalftimeResult = "event_halftime_result"
        case eventFinalResult = "event_final_result"
        case eventPenaltyResult = "event_penalty_result"
        case eventStatus = "event_status"
        case countryName = "country_name"
        case eventStadium = "event_stadium"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case homeTeamKey = "home_team_key"
        case awayTeamKey = "away_team_key"
    }
    
}
