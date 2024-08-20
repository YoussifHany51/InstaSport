//
//  TeamDetailsViewModel.swift
//  InstaSport
//
//  Created by zyad Baset on 18/08/2024.
//

import Foundation
class TeamDetailsViewModel{
    //var teamResult:TeamsResult?
    var teamDetails:TeamModel?
    var teamKey:String
    var sport:Sports
    init(teamKey:String,sport:Sports){
        self.teamKey = teamKey
        self.sport = sport
    }
    func getData(_ handler:@escaping()->Void){
        DataParser().ParsingTeamData( sport: sport, teamKey: teamKey) { decodedData in
            let res = decodedData
            self.teamDetails = res.result.first
            handler()
        }
    }
    
}
