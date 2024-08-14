//
//  LeaguesViewController.swift
//  InstaSport
//
//  Created by Youssif Hany on 12/08/2024.
//

import UIKit
protocol ReloadData{
    func reloadViewData()
}
class LeaguesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,ReloadData {
    @IBOutlet weak var leaguesTableView: UITableView!
    
    var arryOfLeagues : [SportsProtocol]?
//    var league:League?
    var sport:Sports?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        leaguesTableView.dataSource = self
        leaguesTableView.delegate = self
        
        let cellNib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        leaguesTableView.register(cellNib, forCellReuseIdentifier: "leaguesCell")
        checkSport()
    }
    func checkSport(){
        switch sport! {
        case .football:
            LeaguesViewModel(sport: .football) { arr in
                self.arryOfLeagues = arr as! [FootBallModel]
                self.reloadViewData()
            }
        case .basketball:
            LeaguesViewModel(sport: .basketball) { arr in
                self.arryOfLeagues = arr as! [BasketBallModel]
                self.reloadViewData()
            }
        case .tennis:
            LeaguesViewModel(sport: .tennis) { arr in
                self.arryOfLeagues = arr as! [TennisModel]
                self.reloadViewData()
            }
        case .cricket:
            LeaguesViewModel(sport: .cricket) { arr in
                self.arryOfLeagues = arr as! [CricketModel]
                self.reloadViewData()
            }
        }
    }
    
    func reloadViewData(){
        self.leaguesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Num of rows\(arryOfLeagues?.count)")
        return arryOfLeagues?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaguesCell", for: indexPath) as! LeaguesTableViewCell
        //let league = arryOfLeagues![indexPath.row]
        switch sport! {
        case .football:
            let obj = arryOfLeagues![indexPath.row] as! FootBallModel
            cell.setUpLeagueCell(title: obj.leagueName)
        case .basketball:
            let obj = arryOfLeagues![indexPath.row] as! BasketBallModel
            cell.setUpLeagueCell(title: obj.leagueName)
        case .tennis:
            let obj = arryOfLeagues![indexPath.row] as! TennisModel
            cell.setUpLeagueCell(title: obj.leagueName)
        case .cricket:
            let obj = arryOfLeagues![indexPath.row] as! CricketModel
            cell.setUpLeagueCell(title: obj.leagueName)
        }
        return cell
    }
    
}
