//
//  ViewController.swift
//  InstaSport
//
//  Created by Youssif Hany on 12/08/2024.
//

import UIKit

class AllSportsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var allSportsCollectionView: UICollectionView!
    var arryOfSports = AllSportsViewModel().arryOfSports
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Sports"
        allSportsCollectionView.dataSource = self
        allSportsCollectionView.delegate = self
        let cellNib = UINib(nibName: "AllSportsCollectionViewCell", bundle: nil)
        allSportsCollectionView.register(cellNib, forCellWithReuseIdentifier: "allSportsCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arryOfSports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allSportsCell", for: indexPath) as! AllSportsCollectionViewCell
        let sport = arryOfSports[indexPath.row]
        cell.setUpAllSportsCell(photo: sport.image, title: sport.title)
        cell.backgroundColor = .lightGray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.499, height: self.view.frame.height * 0.20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
        vc.sport = arryOfSports[indexPath.row].sportEnum
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
