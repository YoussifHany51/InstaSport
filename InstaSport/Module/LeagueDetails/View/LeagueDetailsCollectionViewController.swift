//
//  LeagueDetailsCollectionViewController.swift
//  InstaSport
//
//  Created by zyad Baset on 16/08/2024.
//

import UIKit
import CoreData



class LeagueDetailsCollectionViewController: UICollectionViewController {
    var viewModel:LeagueDetailsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewModel = LeagueDetailsViewModel(sport: .football)
        viewModel?.getData({
            self.collectionView.reloadData()
        })
        self.collectionView.RegisterNib(cell: TeamsCell.self)
        self.collectionView.RegisterNib(cell: UpComingEventCell.self)
        self.collectionView.RegisterNib(cell: LatestResultCell.self)
        let compositionalLayout = UICollectionViewCompositionalLayout{
            (index , enviroment) in
            if index == 0 {
                return self.drawFirstCollection()
            }
            else if index == 1 {
                return self.drawSecondCollection()

            }else{
                return self.drawThirdCollection()
            }
        }
        self.collectionView.setCollectionViewLayout(compositionalLayout, animated: true)
        self.setupFavoriteButton()
    }
    //func

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if section == 0{
            return viewModel?.arrUpComingEvents.count ?? 0
        }
        else if section == 1 {
            return viewModel?.arrlastEvent.count ?? 0
        }else{
            return viewModel?.setTeams.count ?? 0
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //var cell : UICollectionViewCell?
        if indexPath.section == 0{
            let cell = collectionView.deque(cell: UpComingEventCell.self)
            cell.viewModel = UpComingEventViewModel(obj: viewModel!.arrUpComingEvents[indexPath.row])
            cell.putData()
            return cell
        }
        else if indexPath.section == 1 {
            let cell = collectionView.deque(cell: LatestResultCell.self)
            cell.viewModel = LatestResultViewModel(obj: viewModel!.arrlastEvent[indexPath.row])
            cell.putData()
            return cell
            
        }else{
            let cell = collectionView.deque(cell: TeamsCell.self)
            cell.viewModel = TeamsViewModel(obj: viewModel!.arrTeams[indexPath.row])
            cell.putData()
            return cell
        }
        //cell.imgView
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2{
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsCollectionViewController")as! TeamDetailsCollectionViewController
            VC.viewModel=TeamDetailsViewModel(teamKey: viewModel!.arrTeams[indexPath.row].teamKey, sport: viewModel!.sport)
            //self.navigationController?.pushViewController(VC, animated: true)
            self.present(VC, animated: true)
        }
    }
    func drawFirstCollection() -> NSCollectionLayoutSection{
        // gave the item in group the full size of it
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        // create the item itself
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // create the group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets =   NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
        // create a section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 5, bottom: 5, trailing: 5)
        // animation
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
        items.forEach { item in
        let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
        let minScale: CGFloat = 0.8
        let maxScale: CGFloat = 1.0
        let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
        item.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        }
        return section
    }
    
    func drawSecondCollection() -> NSCollectionLayoutSection{
        // gave the item in group the full size of it
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25))
        // create the item itself
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // create the group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.75))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets =   NSDirectionalEdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0)
        // create a section
        let section = NSCollectionLayoutSection(group: group)
        //section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 5, bottom: 20, trailing: 5)
        return section
    }

    func setupFavoriteButton() {
        let isFavorite = CoreDataManager.shared.isFavorite(league: viewModel!.league,
                                                           arrayOfLeagues: CoreDataManager.shared.fetchSavedLeagues())
        let favoriteButton = UIBarButtonItem(
            image: isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"),
            style: .plain,
            target: self,
            action: #selector(addToFavorites)
        )
        
        navigationItem.rightBarButtonItem = favoriteButton
    }
        
        func drawThirdCollection() -> NSCollectionLayoutSection{
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets =   NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 5, bottom: 5, trailing: 0)
            return section
        }
        // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
            return false
            
        }
    @objc func addToFavorites(){
        if CoreDataManager.shared.isFavorite(league: viewModel!.league,
                                                 arrayOfLeagues: CoreDataManager.shared.fetchSavedLeagues()){
                showAlert()
            }else{
                CoreDataManager.shared.saveLeague(viewModel!.league)
            }
        }
        func showAlert(){
            let alert = UIAlertController(title: "Already in Favorite", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true)
        }
    }

