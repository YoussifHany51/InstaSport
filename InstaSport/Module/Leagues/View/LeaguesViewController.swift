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
    
    var arryOfLeagues : [LeagueModel]?
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
        viewModel=LeaguesViewModel(sport: sport!) { arr in
            self.arryOfLeagues = arr
            self.reloadViewData()
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
        let obj = arryOfLeagues![indexPath.row]
        let check = obj.leagueLogo == nil ? false : true
        switch(sport){
        case .football:cell.setUpLeagueCell(title: obj.leagueName, photo: obj.leagueLogo ?? "imgFB",check: check)
        case .basketball:cell.setUpLeagueCell(title: obj.leagueName, photo: obj.leagueLogo ?? "imgBB",check: check)
        case .cricket:cell.setUpLeagueCell(title: obj.leagueName, photo: obj.leagueLogo ?? "imgC",check: check)
        case .tennis:cell.setUpLeagueCell(title: obj.leagueName, photo: obj.leagueLogo ?? "imgT",check: check)
        case .none:
            break
        }
        
        return cell
    }
    
}
