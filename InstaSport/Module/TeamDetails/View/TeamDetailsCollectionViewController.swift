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
        })
        self.collectionView.RegisterNib(cell: PlayerCardCell.self)
        let compLayout = UICollectionViewCompositionalLayout{
            (index , enviroment) in
            if index == 0 {
                return self.firstCollection()
            }
            else if index == 1{
                return self.secondCollection()
            }
            else {
                return self.thirdCollection()

            }
        }
        
        collectionView.setCollectionViewLayout(compLayout, animated: true)
        
    }

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
        if section == 0{return 1}
        else if  section == 1{return viewModel?.teamDetails?.coaches.count ?? 0}
        else {return viewModel?.teamDetails?.players.count ?? 0}
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
    
    
    func firstCollection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets =   NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        // animation
        return section
    }
    func secondCollection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 5, bottom: 5, trailing: 0)
        return section
        
    }
    
    func thirdCollection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets =   NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 5, bottom: 5, trailing: 0)
        return section
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
