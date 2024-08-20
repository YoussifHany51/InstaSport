//
//  LeagueDetailsCollectionViewController.swift
//  InstaSport
//
//  Created by zyad Baset on 16/08/2024.
//

import UIKit
import CoreData



class LeagueDetailsCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    var viewModel:LeagueDetailsViewModel?
    var checkFav:Bool = false {
        didSet{
            setupFavoriteButton()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getData({
            self.collectionView.reloadData()
        })
        collectionView.register(MyCustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
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
        self.title=viewModel?.league.leagueName
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 10) // Example header size
        }
    //func
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
               let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! MyCustomHeaderView
               switch indexPath.section{
               case 0:header.titleLabel.text = "UpComing Events"
               case 1:header.titleLabel.text = "Latest Events"
               case 2:header.titleLabel.text = "Teams"
               default:header.titleLabel.text = "Section Zyad"
               }
               
               return header
           
           
       }

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
            cell.layer.cornerRadius = 10
            
            return cell
        }
        else if indexPath.section == 1 {
            let cell = collectionView.deque(cell: LatestResultCell.self)
            cell.viewModel = LatestResultViewModel(obj: viewModel!.arrlastEvent[indexPath.row])
            cell.putData()
            cell.layer.cornerRadius = 10

            return cell
            
        }else{
            let cell = collectionView.deque(cell: TeamsCell.self)
            cell.viewModel = TeamsViewModel(obj: viewModel!.arrTeams[indexPath.row])
            cell.putData()
            cell.layer.cornerRadius = 10

            return cell
        }
        //cell.imgView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // create the group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.99), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets =   NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
        // create a section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5)
        // Define the header size
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(10))
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            
            // Add the header to the section
            section.boundarySupplementaryItems = [header]
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        // create the group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.65))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets =   NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        // create a section
        let section = NSCollectionLayoutSection(group: group)
        //section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 5, bottom: 20, trailing: 5)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(10))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        // Add the header to the section
        section.boundarySupplementaryItems = [header]
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
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(120))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets =   NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 5, bottom: 5, trailing: 0)
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(10))
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            // Add the header to the section
            section.boundarySupplementaryItems = [header]
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

    @objc func addToFavorites(){
        if CoreDataManager.shared.isFavorite(league: viewModel!.league,
                                                 arrayOfLeagues: CoreDataManager.shared.fetchSavedLeagues()){
                showAlert()
            
            }else{
                CoreDataManager.shared.saveLeague(viewModel!.league,sport:viewModel!.sport)
                checkFav=true
            }
        }
        func showAlert(){
            let alert = UIAlertController(title: "are U sure to delete", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { alert in
                CoreDataManager.shared.removeLeague(leagueKey: self.viewModel!.league.leagueKey)
                self.checkFav = false
            }
            alert.addAction(action)
            let action2 = UIAlertAction(title: "Cancel", style: .default,handler: nil)
            alert.addAction(action2)
            self.present(alert,animated: true)
        }
    }

