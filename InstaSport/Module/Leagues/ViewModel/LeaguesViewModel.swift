//
//  LeaguesViewModel.swift
//  InstaSport
//
//  Created by Youssif Hany on 13/08/2024.
//

import Foundation
import Kingfisher
class LeaguesViewModel{
    var sport:Sports
    var arrayOfLeagues:[LeagueModel] = []
    init(sport:Sports,handler:@escaping(_ arr:[LeagueModel])->Void){
        self.sport=sport
        
        DataParser().parsingFBData(ClassType: LeagueResult.self, checkSportOrLeague: true, sport: sport) { decodedData in
            let res = decodedData
            self.arrayOfLeagues = res.result
            handler(self.arrayOfLeagues)
        }
        
        }
    }
