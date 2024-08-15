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
    var sport:Sports?
    var activityIndicator: UIActivityIndicatorView!
    var leaguesViewModel: LeaguesViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        leaguesTableView.dataSource = self
        leaguesTableView.delegate = self
        
        let cellNib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        leaguesTableView.register(cellNib, forCellReuseIdentifier: "leaguesCell")
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        checkSport()
    }
    func checkSport(){
        activityIndicator.startAnimating()
        switch sport! {
        case .football:
            leaguesViewModel = LeaguesViewModel(sport: .football) { arr in
                self.arryOfLeagues = arr as! [FootBallModel]
                self.reloadViewData()
            }
        case .basketball:
            leaguesViewModel = LeaguesViewModel(sport: .basketball) { arr in
                self.arryOfLeagues = arr as! [BasketBallModel]
                self.reloadViewData()
            }
        case .tennis:
            leaguesViewModel = LeaguesViewModel(sport: .tennis) { arr in
                self.arryOfLeagues = arr as! [TennisModel]
                self.reloadViewData()
            }
        case .cricket:
            leaguesViewModel = LeaguesViewModel(sport: .cricket) { arr in
                self.arryOfLeagues = arr as! [CricketModel]
                self.reloadViewData()
            }
        }
    }
    
    func reloadViewData(){
        activityIndicator.stopAnimating()
        self.leaguesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arryOfLeagues?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaguesCell", for: indexPath) as! LeaguesTableViewCell
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
