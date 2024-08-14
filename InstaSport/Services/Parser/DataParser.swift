//
//  DataParser.swift
//  InstaSport
//
//  Created by zyad Baset on 12/08/2024.
//

import Foundation
class DataParser{
    func parsingFBData(sport:Sports,handler:@escaping(_ decodedData:SportsProtocol)->Void){
//        var decodedData:FootBallResult?
        NWService(sport: sport).fetchLeaguesAPIData { data in
            do{
                switch sport{
                case .football:let decodedData = try JSONDecoder().decode(FootBallResult.self, from: data)
                    handler(decodedData)
                case .basketball:
                    let decodedData = try JSONDecoder().decode(BasketBallResult.self, from: data)
                        handler(decodedData)
                case .tennis:let decodedData = try JSONDecoder().decode(TennisResult.self, from: data)
                    handler(decodedData)
                    
                case .cricket:let decodedData = try JSONDecoder().decode(CricketResult.self, from: data)
                    handler(decodedData)
                }
            }catch{
                print("Error in decoding Data")
            }
        }
//        return decodedData!
    }
}
