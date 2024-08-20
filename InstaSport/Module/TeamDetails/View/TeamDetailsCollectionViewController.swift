//
//  TeamDetailsCollectionViewController.swift
//  InstaSport
//
//  Created by zyad Baset on 18/08/2024.
//

import UIKit



class TeamDetailsCollectionViewController: UICollectionViewController {
    var viewModel:TeamDetailsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getData({
            self.collectionView.reloadData()
            self.title=self.viewModel?.teamDetails?.teamName
        })
        regestringNibFilesandHeaderSection()
        addingCompositionalLayout()
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if section == 0{return 1}
        else if  section == 1{return viewModel?.teamDetails?.coaches.count ?? 0}
        else {return viewModel?.teamDetails?.players.count ?? 0}
    }

    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
               let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! MyCustomHeaderView
               switch indexPath.section{
               case 0:header.titleLabel.text = viewModel?.teamDetails?.teamName
               case 1:header.titleLabel.text = "Coaches"
               case 2:header.titleLabel.text = "Players"
               default:header.titleLabel.text = "Section Zyad"
               }
               return header
       }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
            if let imgStr = viewModel?.teamDetails?.teamLogo{
                if let url = URL(string:imgStr){
                    (cell.viewWithTag(1)as! UIImageView).kf.setImage(with: url)
                }else{
                    (cell.viewWithTag(1)as! UIImageView).image=UIImage(named: "imgFB")
                }}else{
                    (cell.viewWithTag(1)as! UIImageView).image=UIImage(named: "imgFB")
                }
            return cell
        }
        else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath)
            
            (cell.viewWithTag(1)as! UILabel).text = viewModel?.teamDetails?.coaches[indexPath.row].coachName
            return cell
            
        }else{
            let cell = collectionView.deque(cell: PlayerCardCell.self)
            cell.viewModel = PlayerCardViewModel(player: (viewModel?.teamDetails?.players[indexPath.row])!)
            cell.putData()
            return cell
        }
    
        // Configure the cell
    }

}
