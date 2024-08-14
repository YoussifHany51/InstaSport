//
//  AllSportsCollectionViewCell.swift
//  InstaSport
//
//  Created by Youssif Hany on 12/08/2024.
//

import UIKit

class AllSportsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var allSportImageLabel: UIImageView!
    
    @IBOutlet weak var allSportsTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpAllSportsCell(photo:UIImage,title:String){
        allSportsTitleLabel.text = title
        allSportImageLabel.image = photo
    }
}
