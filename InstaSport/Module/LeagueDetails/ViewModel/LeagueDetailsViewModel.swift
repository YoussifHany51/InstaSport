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
    init(sport:Sports,leagueNum:String,league:LeagueCD) {
        self.sport=sport
        self.leagueNum=leagueNum
        self.league = LeagueModel(league: league)
    }
    
    
    func getData(_ handler: @escaping () -> Void) {
        // UpComingEvent Parser
        DataParser().parsingFBData(ClassType: EventResult.self, checkSportOrLeague: false, checkUpComingOrLastEvents: true, leagueId: leagueNum, sport: sport) { decodedData in
            let res = decodedData
            self.arrUpComingEvents = res.result
            print("Try to decode Upcoming")
            for item in self.arrUpComingEvents {
                let obj = TeamsModel(imgUrl: item.homeTeamLogo ?? "imgFB", teamKey: "\(item.homeTeamKey)", teamName: item.eventHomeTeam ?? "Home team")
                let obj2 = TeamsModel(imgUrl: item.awayTeamLogo ?? "imgFB", teamKey: "\(item.awayTeamKey)", teamName: item.eventAwayTeam ?? "Home team")
                self.setTeams.insert(obj)
                self.setTeams.insert(obj2)
                print(self.setTeams.count)
            }
            self.arrTeams = Array(self.setTeams)
            
            if self.arrUpComingEvents.count == 0 {
                self.putDefaultUpComingEventValue()
            }
            
            // Nested parser for last event
            DataParser().parsingFBData(ClassType: EventResult.self, checkSportOrLeague: false, checkUpComingOrLastEvents: false, leagueId: self.leagueNum, sport: self.sport) { decodedData in
                let res = decodedData
                self.arrlastEvent = res.result
                print("Try to decode LastEvent")
                for item in self.arrlastEvent {
                    let obj = TeamsModel(imgUrl: item.homeTeamLogo ?? "imgFB", teamKey: "\(item.homeTeamKey)", teamName: item.eventHomeTeam ?? "HomeTeam")
                    let obj2 = TeamsModel(imgUrl: item.awayTeamLogo ?? "imgFB", teamKey: "\(item.awayTeamKey)", teamName: item.eventAwayTeam ?? "AwayTeam")
                    self.setTeams.insert(obj)
                    self.setTeams.insert(obj2)
                    print(self.setTeams.count)
                }
                self.arrTeams = Array(self.setTeams)
                
                if self.arrlastEvent.count == 0 {
                    self.putDefaultLastEventValue()
                }
                if self.arrTeams.count == 0 {
                    self.putDefaultTeamValue()
                }
                
                handler() // Call handler here, ensuring it's only called once
            }
        }
    }
//    func getData(_ handler:@escaping()->Void){
//        //UpComingEvent Parser
//        DataParser().parsingFBData(ClassType: EventResult.self, checkSportOrLeague: false, checkUpComingOrLastEvents: true,leagueId: leagueNum, sport: sport) { decodedData in
//            let res = decodedData
//            self.arrUpComingEvents=res.result
//            print("Try to decode Upcoming")
//            for item in self.arrUpComingEvents{
//                let obj = TeamsModel(imgUrl: item.homeTeamLogo ?? "imgFB", teamKey: "\(item.homeTeamKey)", teamName: item.eventHomeTeam ?? "Home team")
//                let obj2 = TeamsModel(imgUrl: item.awayTeamLogo ?? "imgFB", teamKey: "\(item.awayTeamKey)", teamName: item.eventAwayTeam ?? "Home team")
//                self.setTeams.insert(obj)
//                self.setTeams.insert(obj2)
//                print(self.setTeams.count)
//            }
//            self.arrTeams = Array(self.setTeams)
//            handler()
//        }
//        if self.arrUpComingEvents.count == 0{
//            self.putDefaultUpComingEventValue()
//        }
//        handler()
//        DataParser().parsingFBData(ClassType: EventResult.self, checkSportOrLeague: false, checkUpComingOrLastEvents: false, leagueId: leagueNum,sport: sport) { decodedData in
//            let res = decodedData
//            self.arrlastEvent=res.result
//            print("Try to decode LastEvent")
//            for item in self.arrUpComingEvents{
//                let obj = TeamsModel(imgUrl: item.homeTeamLogo ?? "imgFB", teamKey: "\(item.homeTeamKey)", teamName: item.eventHomeTeam ?? "HomeTeam")
//                let obj2 = TeamsModel(imgUrl: item.awayTeamLogo ?? "imgFB", teamKey: "\(item.awayTeamKey)", teamName: item.eventAwayTeam ?? "AwayTeam")
//                self.setTeams.insert(obj)
//                self.setTeams.insert(obj2)
//                print(self.setTeams.count)
//            }
//            self.arrTeams = Array(self.setTeams)
//            
//            handler()
//        }
//        if self.arrlastEvent.count == 0{
//            self.putDefaultLastEventValue()
//        }
//        if self.arrTeams.count == 0{
//            self.putDefaultTeamValue()
//        }
//        handler()
//    }
    
    
    
    func putDefaultLastEventValue(){
        arrlastEvent.append(EventModel())
    }
    func putDefaultUpComingEventValue(){
        arrUpComingEvents.append(EventModel(i: 0))
    }
    func putDefaultTeamValue(){
        arrTeams.append(TeamsModel(imgUrl: "Error", teamKey: "", teamName: "NO Teams"))
    }
}
