//
//  LeaguesViewController.swift
//  InstaSport
//
//  Created by Youssif Hany on 12/08/2024.
//

import UIKit
//protocol ReloadData{
//    func reloadViewData()
//}
class LeaguesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var leaguesTableView: UITableView!
    
    var arryOfLeagues : [SportsProtocol]?
    var viewModel:LeaguesViewModel?
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
            viewModel=LeaguesViewModel(sport: .football) { arr in
                self.arryOfLeagues = arr as! [FootBallModel]
                self.reloadViewData()
            }
        case .basketball:
            viewModel=LeaguesViewModel(sport: .basketball) { arr in
                self.arryOfLeagues = arr as! [BasketBallModel]
                self.reloadViewData()
            }
        case .tennis:
            viewModel=LeaguesViewModel(sport: .tennis) { arr in
                self.arryOfLeagues = arr as! [TennisModel]
                self.reloadViewData()
            }
        case .cricket:
            viewModel=LeaguesViewModel(sport: .cricket) { arr in
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
            let check = obj.leagueLogo == nil ? false : true
            cell.setUpLeagueCell(title: obj.leagueName, photo: obj.leagueLogo ?? "imgFB",check: check)
        case .basketball:
            let obj = arryOfLeagues![indexPath.row] as! BasketBallModel
            cell.setUpLeagueCell(title: obj.leagueName, photo: "imgBB",check: false)
        case .tennis:
            let obj = arryOfLeagues![indexPath.row] as! TennisModel
            cell.setUpLeagueCell(title: obj.leagueName, photo: "imgT",check: false)
        case .cricket:
            let obj = arryOfLeagues![indexPath.row] as! CricketModel
            cell.setUpLeagueCell(title: obj.leagueName, photo: "imgC",check: false)
        }
        return cell
    }
    
}
