//
//  LeaguesTableViewController.swift
//  InstaSport
//
//  Created by Youssif Hany on 17/08/2024.
//

import UIKit
class LeaguesTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    //@IBOutlet var leaguesTableView: UITableView!
    var imageEmptyData:UIImageView?
    var viewModel:LeaguesViewModel?
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
    }
    
    func LeagueViewLoad(){
        viewModel?.getData {
            self.tableView.reloadData()
        }
        if NetworkConnectionManager.shared.isConnected{
            let cellNib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
            tableView.register(cellNib, forCellReuseIdentifier: "leaguesCell")
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.center = self.view.center
            self.view.addSubview(activityIndicator)
        }else{
            noConnection()
        }
        self.title=viewModel?.sport.rawValue
        
    }
    func favoriteViewLoad(){
        let cellNib = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        
        tableView.register(cellNib, forCellReuseIdentifier: "favoriteCell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if(viewModel!.checkFavorite){
            viewModel?.reloadCoreData()
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
            
            tableView.reloadData()
        }
        
    }
    
    func reloadViewData(){
        activityIndicator.stopAnimating()
        self.tableView.reloadData()
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
            case .cricket:cell.setUpLeagueCell(title: obj!.leagueName, photo: obj?.leagueLogo ?? "imgC",check: check)
            case .tennis:cell.setUpLeagueCell(title: obj!.leagueName, photo: obj?.leagueLogo ?? "imgT",check: check)
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
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(confirm)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if NetworkConnectionManager.shared.isConnected{
            self.performSegue(withIdentifier: "pushView", sender: self)
        }else{
            noConnection()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushView"{
            if let destination = segue.destination as? LeagueDetailsCollectionViewController{
                if let indexPath = self.tableView.indexPathForSelectedRow{
                    if(viewModel!.checkFavorite){
                        let str = "\(viewModel!.arrFav[indexPath.row].leagueKey)"
                        destination.viewModel = LeagueDetailsViewModel(sport: conVstrToSports(str: viewModel!.arrFav[indexPath.row].sport!), leagueNum: str,league: viewModel!.arrFav[indexPath.row])
                    }else{
                        let str = "\(viewModel!.arrayOfLeagues[indexPath.row].leagueKey)"
                        destination.viewModel = LeagueDetailsViewModel(sport: viewModel!.sport, leagueNum: str,league: viewModel!.arrayOfLeagues[indexPath.row])
                    }
                }
            }
        }
        
    }
    func conVstrToSports(str:String)->Sports{
        switch(str){
        case "football":return .football
        case "basketball":return .basketball
        case "cricket": return .cricket
        case "tennis":return .tennis
        default:
            return .football
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
        tableView.backgroundView = noConnectionImageView
    }
    
    
}
