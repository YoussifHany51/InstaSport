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
    var setTeams :Set<TeamsModel>=[]
    var arrTeams:[TeamsModel]=[]
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
            for item in self.arrUpComingEvents{
                let obj = TeamsModel(imgUrl: item.homeTeamLogo ?? "imgFB", teamKey: "\(item.homeTeamKey)", teamName: item.eventHomeTeam)
                let obj2 = TeamsModel(imgUrl: item.awayTeamLogo ?? "imgFB", teamKey: "\(item.awayTeamKey)", teamName: item.eventAwayTeam)
                self.setTeams.insert(obj)
                self.setTeams.insert(obj2)
                print(self.setTeams.count)
            }
            self.arrTeams = Array(self.setTeams)
            handler()
        }
        DataParser().parsingFBData(ClassType: EventResult.self, checkSportOrLeague: false, checkUpComingOrLastEvents: false, leagueId: leagueNum,sport: sport) { decodedData in
            let res = decodedData
            self.arrlastEvent=res.result
            print("Try to decode LastEvent")
            for item in self.arrUpComingEvents{
                let obj = TeamsModel(imgUrl: item.homeTeamLogo ?? "imgFB", teamKey: "\(item.homeTeamKey)", teamName: item.eventHomeTeam)
                let obj2 = TeamsModel(imgUrl: item.awayTeamLogo ?? "imgFB", teamKey: "\(item.awayTeamKey)", teamName: item.eventAwayTeam)
                self.setTeams.insert(obj)
                self.setTeams.insert(obj2)
                print(self.setTeams.count)
            }
            handler()
        }
    }
}
