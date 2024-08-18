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
        let selectedLeague = arrayOfFavorite[indexPath.row]
        CoreDataManager.shared.removeLeague(leagueKey: Int(selectedLeague.leagueKey))
        arrayOfFavorite.remove(at: indexPath.row)
        favoriteTableView.deleteRows(at: [indexPath], with: .automatic)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
}
