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
    var arrayOfLeagues:[SportsProtocol] = []
    //var view:ReloadData?
    init(sport:Sports,handler:@escaping(_ arr:[SportsProtocol])->Void){
        self.sport=sport
        // self.view=view
        switch self.sport {
        case .football: DataParser().parsingFBData(sport: sport) { decodedData in
            let res = decodedData as! FootBallResult
            self.arrayOfLeagues = res.result
            handler(self.arrayOfLeagues)
            //self.view?.reloadViewData()
        }
        case .basketball: DataParser().parsingFBData(sport: sport) { decodedData in
            let res = decodedData as! BasketBallResult
            self.arrayOfLeagues = res.result
            handler(self.arrayOfLeagues)
            //self.view?.reloadViewData()
        }
        case .tennis: DataParser().parsingFBData(sport: sport) { decodedData in
            let res = decodedData as! TennisResult
            self.arrayOfLeagues = res.result
            handler(self.arrayOfLeagues)
            //self.view?.reloadViewData()
        }
        case .cricket: DataParser().parsingFBData(sport: sport) { decodedData in
            let res = decodedData as! CricketResult
            self.arrayOfLeagues = res.result
            handler(self.arrayOfLeagues)
            //self.view?.reloadViewData()
        }
        }
    }
}
