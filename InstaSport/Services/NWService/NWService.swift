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
    
    init(sport: Sports) {
        self.sport = sport
    }
    func fetchLeaguesAPIData(handler:@escaping(_ data:Data)->Void){
        let param: [String: Any] = [
            "met": "Leagues",
            "APIkey": "2c28d4947373c9aad33c4b48c0f99c79ce4469f4c59f207b0ee9d8f73d2ae9e2"
        ]
        AF.request(fullURL,method: .get,parameters: param,encoding: URLEncoding.default,headers: nil,interceptor: nil).response { response in
            switch response.result{
            case .success(let data):handler(data!)
            case .failure(let error):print("Error in fetching data\(error.localizedDescription)")
            }
        }

    }
//    func fetchImageAsData(strUrl:String,handler:@escaping(_ data1:Data?)->Void) {
//
//        guard let url = URL(string: strUrl) else { return }
//        DispatchQueue.global().async {
//            if let data = try? Data(contentsOf: url) {
//                handler(data)
//            }else{
//                handler(nil)
//            }
//        }
//    }
}
