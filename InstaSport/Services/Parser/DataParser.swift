//
//  DataParser.swift
//  InstaSport
//
//  Created by zyad Baset on 12/08/2024.
//

import Foundation
class DataParser{
    func parsingFBData<ClassType : Decodable>(ClassType : ClassType.Type,checkSportOrLeague:Bool,checkUpComingOrLastEvents:Bool=false,leagueId:String="305",sport:Sports,handler:@escaping(_ decodedData:ClassType)->Void){
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
}
