//
//  TeamsCell.swift
//  InstaSport
//
//  Created by zyad Baset on 16/08/2024.
//

import UIKit

class TeamsCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    var viewModel:TeamsViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func putData(){
        lblTitle.text = viewModel?.obj.teamName
        if let imgStr = viewModel?.obj.imgUrl{
            if let url = URL(string:imgStr){
                imgLogo.kf.setImage(with: url)
            }else{
                imgLogo.image=UIImage(named: "imgFB")
            }}else{
                imgLogo.image=UIImage(named: "imgFB")
            }
    }

}
