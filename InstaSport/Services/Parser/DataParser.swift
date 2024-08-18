//
//  DataParser.swift
//  InstaSport
//
//  Created by zyad Baset on 12/08/2024.
//

import Foundation
class DataParser{
    func parsingFBData<ClassType : Decodable>(ClassType : ClassType.Type,checkSportOrLeague:Bool,checkUpComingOrLastEvents:Bool=false,leagueId:String="305",sport:Sports,teamKey:Int=96,handler:@escaping(_ decodedData:ClassType)->Void){
        NWService(checkSportOrLeague:checkSportOrLeague, checkUpComingOrLastEvents: checkUpComingOrLastEvents, sport: sport).fetchLeaguesAPIData(leagueID: leagueId) { data in
            do{
                let decodedData = try JSONDecoder().decode(ClassType, from: data)
                   handler(decodedData)
            }catch{
                print("Error in decoding Data")
            }
        }
//        return decodedData!
    }
    func ParsingTeamData(sport:Sports,teamKey:String,handler:@escaping(_ decodedData:TeamsResult)->Void){
        NWService(checkSportOrLeague: true, checkUpComingOrLastEvents: true, sport: sport).fetchTeamDetails(teamId: teamKey) { data in
            do{
                let decodedData = try JSONDecoder().decode(TeamsResult.self, from: data)
                   handler(decodedData)
            }catch {
                print("Error in decoding TeamDetails Data")
            }
        }
        
    }
}
