//
//  NWServiceFootBall.swift
//  InstaSport
//
//  Created by zyad Baset on 12/08/2024.
//

import Foundation
import Alamofire
class NWService{
    let url = "https://apiv2.allsportsapi.com/"
    let sport:Sports?
    var fullURL:String{
        url+sport!.rawValue+"/?"
    }
    var checkSportOrLeague:Bool  //false leaguesDetails
    var checkUpComingOrLastEvents:Bool //true upComingEvent
    
    init(checkSportOrLeague:Bool,checkUpComingOrLastEvents:Bool,sport: Sports) {
        self.sport = sport
        self.checkSportOrLeague = checkSportOrLeague
        self.checkUpComingOrLastEvents = checkUpComingOrLastEvents
    }
    //met=Teams&teamId=96&APIkey=2c28d4947373c9aad33c4b48c0f99c79ce4469f4c59f207b0ee9d8f73d2ae9e2
    func fetchTeamDetails(teamId:String,handler:@escaping(_ data:Data)->Void){
        var param:[String:Any]=[:]
        param = ["met":"Teams","teamId":teamId,"APIkey": "2c28d4947373c9aad33c4b48c0f99c79ce4469f4c59f207b0ee9d8f73d2ae9e2"]
        AF.request(fullURL,method: .get,parameters: param,encoding: URLEncoding.default,headers: nil,interceptor: nil).response { response in
            switch response.result{
            case .success(let data):print("Fetch Teams Details data success")
                print(data)
                handler(data!)
            case .failure(let error):print("Error in fetching data\(error.localizedDescription)")
            }
        }
    }
    
    func fetchLeaguesAPIData(leagueID:String="305",handler:@escaping(_ data:Data)->Void){
        var param:[String:Any]=[:]
        
        if (checkSportOrLeague){
        param = [
           "met": "Leagues",
           "APIkey": "2c28d4947373c9aad33c4b48c0f99c79ce4469f4c59f207b0ee9d8f73d2ae9e2"
       ]
        }else{
            param = ["met":"Fixtures",
                     "leagueId":leagueID,
                     "from":checkUpComingOrLastEvents ? DateOptimizer.currentDate : DateOptimizer.oneYearBefore,
                     "to":checkUpComingOrLastEvents ? DateOptimizer.oneYearAfter : DateOptimizer.currentDate,
                     "APIkey": "2c28d4947373c9aad33c4b48c0f99c79ce4469f4c59f207b0ee9d8f73d2ae9e2"]
        }
         
        AF.request(fullURL,method: .get,parameters: param,encoding: URLEncoding.default,headers: nil,interceptor: nil).response { response in
            switch response.result{
            case .success(let data):print("Fetch data success");handler(data!)
            case .failure(let error):print("Error in fetching data\(error.localizedDescription)")
            }
        }

    }
}
