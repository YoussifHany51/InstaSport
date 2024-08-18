//
//  LeagueDetailsViewModel.swift
//  InstaSport
//
//  Created by zyad Baset on 16/08/2024.
//

import Foundation

class LeagueDetailsViewModel{
    var arrUpComingEvents : [EventModel] = []
    var arrlastEvent : [EventModel] = []
    var leagueNum:String
    var sport:Sports
    var league:LeagueModel
    init(sport:Sports,leagueNum:String,league:LeagueModel){
        self.sport=sport
        self.leagueNum=leagueNum
        self.league = league
        //getData()
    }
    func getData(_ handler:@escaping()->Void){
        DataParser().parsingFBData(ClassType: EventResult.self, checkSportOrLeague: false, checkUpComingOrLastEvents: true,leagueId: leagueNum, sport: sport) { decodedData in
            let res = decodedData
            self.arrUpComingEvents=res.result
            print("Try to decode Upcoming")
            handler()
            
        }
        DataParser().parsingFBData(ClassType: EventResult.self, checkSportOrLeague: false, checkUpComingOrLastEvents: false, leagueId: leagueNum,sport: sport) { decodedData in
            let res = decodedData
            self.arrlastEvent=res.result
            print("Try to decode LastEvent")
            handler()
        }
    }
}
