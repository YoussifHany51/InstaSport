//
//  DataParser.swift
//  InstaSport
//
//  Created by zyad Baset on 12/08/2024.
//

import Foundation
class DataParser{
    func parsingFBData<ClassType : Decodable>(ClassType : ClassType.Type,checkLeagueOrSport:Bool,checkUpComingOrLastEvents:Bool=false,sport:Sports,handler:@escaping(_ decodedData:ClassType)->Void){
//        var decodedData:FootBallResult?
        NWService(checkLeagueOrSport:checkLeagueOrSport , checkUpComingOrLastEvents: checkUpComingOrLastEvents, sport: sport).fetchLeaguesAPIData(leagueID: "305") { data in
            do{
                    let decodedData = try JSONDecoder().decode(ClassType.self, from: data)
                   handler(decodedData)
            }catch{
                print("Error in decoding Data")
            }
        }
//        return decodedData!
    }
}
