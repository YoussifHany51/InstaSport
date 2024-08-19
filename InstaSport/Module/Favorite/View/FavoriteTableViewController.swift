//
//  FavoriteTableViewController.swift
//  InstaSport
//
//  Created by Youssif Hany on 17/08/2024.
//

import UIKit

class FavoriteTableViewController: UITableViewController {

    @IBOutlet var favoriteTableView: UITableView!
    var arrayOfFavorite : [LeagueCD] = []
    var sport:Sports?
    var imageEmptyData:UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
        
        let cellNib = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        favoriteTableView.register(cellNib, forCellReuseIdentifier: "favoriteCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        arrayOfFavorite = CoreDataManager.shared.fetchSavedLeagues()
        if arrayOfFavorite.isEmpty {
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
            
            favoriteTableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfFavorite.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
        cell.favCell = arrayOfFavorite[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Caution", message: "Are you sure ?", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Confirm", style: .destructive) {[weak self] _ in
            let selectedLeague = self?.arrayOfFavorite[indexPath.row]
            CoreDataManager.shared.removeLeague(leagueKey: Int(selectedLeague!.leagueKey))
            self?.arrayOfFavorite.remove(at: indexPath.row)
            self?.favoriteTableView.deleteRows(at: [indexPath], with: .automatic)
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
        self.performSegue(withIdentifier: "pushToDetails", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if NetworkConnectionManager.shared.isConnected{
            if segue.identifier == "pushToDetails"{
                if let destination = segue.destination as? LeagueDetailsCollectionViewController{
                    if let indexPath = self.favoriteTableView.indexPathForSelectedRow{
                        let leagueCD = arrayOfFavorite[indexPath.row]
                        let leagueModel = LeagueModel(from: leagueCD)
                        let str = "\(leagueModel.leagueKey)"
                        destination.viewModel = LeagueDetailsViewModel(sport: sport ?? .football, leagueNum: str,league: leagueModel)
                    }
                }
            }
        }else{
            showNetworkAlert()
        }
    }
    func showNetworkAlert(){
        let alert = UIAlertController(title: "Ops ☹️", message: "Network Error", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
