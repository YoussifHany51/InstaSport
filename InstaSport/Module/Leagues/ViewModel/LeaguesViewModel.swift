//
//  LeaguesViewModel.swift
//  InstaSport
//
//  Created by Youssif Hany on 13/08/2024.
//

import Foundation
class LeaguesViewModel{
    var sport:Sports
    var arrayOfLeagues:[LeagueModel] = []
    var arrFav:[LeagueCD]=[]
    var checkFavorite:Bool
    init(sport:Sports,checkFavorite:Bool){
        self.sport=sport
        self.checkFavorite=checkFavorite
        if(checkFavorite){
            arrFav = CoreDataManager.shared.fetchSavedLeagues()
        }
    }
    func getData(handler:@escaping()->Void){
        DataParser().parsingFBData(ClassType: LeagueResult.self, checkSportOrLeague: true, sport: sport) { decodedData in
            let res = decodedData
            self.arrayOfLeagues = res.result
            handler()
        }
        
    }
    }
