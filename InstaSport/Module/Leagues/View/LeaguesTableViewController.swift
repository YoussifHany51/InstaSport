//
//  LeaguesTableViewController.swift
//  InstaSport
//
//  Created by Youssif Hany on 17/08/2024.
//

import UIKit

class LeaguesTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var leaguesTableView: UITableView!
    var arryOfLeagues : [LeagueModel]?
    var viewModel:LeaguesViewModel?
    var sport:Sports?
    var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if NetworkConnectionManager.shared.isConnected{
            leaguesTableView.dataSource = self
            leaguesTableView.delegate = self
            
            let cellNib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
            leaguesTableView.register(cellNib, forCellReuseIdentifier: "leaguesCell")
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.center = self.view.center
            self.view.addSubview(activityIndicator)
            checkSport()
        }else{
            noConnection()
        }
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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arryOfLeagues?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaguesCell", for: indexPath) as! LeaguesTableViewCell
        cell.layer.cornerRadius = 10
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "pushView", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushView"{
            if let destination = segue.destination as? LeagueDetailsCollectionViewController{
                if let indexPath = self.leaguesTableView.indexPathForSelectedRow{
                    let str = "\(viewModel!.arrayOfLeagues[indexPath.row].leagueKey)"
                    destination.viewModel = LeagueDetailsViewModel(sport: sport!, leagueNum: str,league: arryOfLeagues![indexPath.row])
                }
            }
        }
    }
    func alertNoNetworkPresent(){
        let alert = UIAlertController(title: "Oops☹️", message: "Please connect to internet !", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func noConnection(){
        setBackgroundNoConnection()
        DispatchQueue.main.async {
            self.alertNoNetworkPresent()
        }
    }
    func setBackgroundNoConnection(){
        let noConnectionImageView : UIImageView = {
            let iv = UIImageView()
            iv.image = UIImage(systemName: "icloud.slash")
            iv.tintColor = .gray
            iv.contentMode = .scaleAspectFit
            return iv
        }()
        self.leaguesTableView.backgroundView = noConnectionImageView
    }


}
