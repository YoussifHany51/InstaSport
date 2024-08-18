//
//  NWParamters.swift
//  InstaSport
//
//  Created by zyad Baset on 18/08/2024.
//

import Foundation

enum APIValidation : String {
    
    case leagues = "Leagues"
    case teamsDetails = "Teams"
    case fixtures = "Fixtures"
}
let apiKey = "2c28d4947373c9aad33c4b48c0f99c79ce4469f4c59f207b0ee9d8f73d2ae9e2"
class param {
    func getParam(metValue : APIValidation,teamId : Int = 96,from : String,to : String, leagueId : String) -> [String: String] {
        
        switch metValue {
        case .teamsDetails :
            return ["met" : metValue.rawValue,"teamId" : "\(teamId)","APIkey" : apiKey]
        case .fixtures :
            return ["met" : metValue.rawValue,"leagueId" :"\(leagueId)", "APIkey" : apiKey]
        default :
            return ["met" : metValue.rawValue,"APIkey" : apiKey]
            
        }
    }
}
