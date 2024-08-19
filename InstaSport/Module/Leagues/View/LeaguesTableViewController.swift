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
    var imageEmptyData:UIImageView?
    //var arryOfLeagues : [LeagueModel]?
    var viewModel:LeaguesViewModel?
    //var sport:Sports?
    var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let _ = viewModel{
            
        }else{
            viewModel=LeaguesViewModel(sport: .football, checkFavorite: true)
        }
        if(viewModel!.checkFavorite){
            favoriteViewLoad()
        }else{
            LeagueViewLoad()
        }
        // Do any additional setup after loading the view.
        
        
        

    }
    
    func LeagueViewLoad(){
        viewModel?.getData {
            self.tableView.reloadData()
        }
        if NetworkConnectionManager.shared.isConnected{
            let cellNib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
            leaguesTableView.register(cellNib, forCellReuseIdentifier: "leaguesCell")
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.center = self.view.center
            self.view.addSubview(activityIndicator)
            //checkSport()
        }else{
            noConnection()
        }
        self.title=viewModel?.sport.rawValue
        
    }
    func favoriteViewLoad(){
        let cellNib = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        
        leaguesTableView.register(cellNib, forCellReuseIdentifier: "favoriteCell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if(viewModel!.checkFavorite){
            if viewModel!.arrFav.isEmpty {
                    if imageEmptyData == nil { // Only add the image if it's not already added
                        imageEmptyData = UIImageView(frame: CGRect(
                            x: 50, y: 100,
                            width: self.view.frame.width - 100, height: 200))
                        imageEmptyData?.image = UIImage(named: "noData")
                        self.view.addSubview(imageEmptyData!)
                    }
                } else {
                    // Remove the empty state image if it exists
                    imageEmptyData?.removeFromSuperview()
                    imageEmptyData = nil
                }
                
            leaguesTableView.reloadData()
        }
        
    }
//    func checkSport(){
//        activityIndicator.startAnimating()
//        viewModel=LeaguesViewModel(sport: sport!, checkFavorite: false)
//    }
    
    func reloadViewData(){
        activityIndicator.stopAnimating()
        self.leaguesTableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(viewModel!.checkFavorite){
            return viewModel?.arrFav.count ?? 0
        }else{
            return viewModel?.arrayOfLeagues.count ?? 0
        }
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(viewModel!.checkFavorite){
            let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
            cell.favCell = viewModel?.arrFav[indexPath.row]
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "leaguesCell", for: indexPath) as! LeaguesTableViewCell
            cell.layer.cornerRadius = 10
            let obj = viewModel?.arrayOfLeagues[indexPath.row]
            let check = obj?.leagueLogo == nil ? false : true
            switch(viewModel?.sport){
            case .football:cell.setUpLeagueCell(title: obj!.leagueName, photo: obj?.leagueLogo ?? "imgFB",check: check)
            case .basketball:cell.setUpLeagueCell(title: obj!.leagueName, photo: obj?.leagueLogo ?? "imgBB",check: check)
            case .cricket:cell.setUpLeagueCell(title: obj.leagueName, photo: obj.leagueLogo ?? "imgC",check: check)
            case .tennis:cell.setUpLeagueCell(title: obj.leagueName, photo: obj.leagueLogo ?? "imgT",check: check)
            case .none:
                break
            }
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Caution", message: "Are you sure ?", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Confirm", style: .destructive) {[weak self] _ in
            let selectedLeague = self?.viewModel?.arrFav[indexPath.row]
            CoreDataManager.shared.removeLeague(leagueKey: Int(selectedLeague!.leagueKey))
            self?.viewModel?.arrFav.remove(at: indexPath.row)
            self?.leaguesTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(confirm)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
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
