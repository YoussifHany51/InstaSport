//
//  PlayerCardCell.swift
//  InstaSport
//
//  Created by zyad Baset on 18/08/2024.
//

import UIKit

class PlayerCardCell: UICollectionViewCell {

    @IBOutlet weak var lblPosition: UILabel!
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var imgViewPlayer: UIImageView!
    
    @IBOutlet weak var lblNum: UILabel!
    var viewModel : PlayerCardViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius=20
        view.layer.shadowRadius=10
        view.layer.borderWidth=2
        view.layer.borderColor=UIColor.gray.cgColor
        // Initialization code
    }
    func putData(){
        if let imgStr = viewModel?.player.playerImage{
            if let url = URL(string:imgStr){
                imgViewPlayer.kf.setImage(with: url)
            }else{
                imgViewPlayer.image=UIImage(named: "ImgPlayer")
            }}else{
                imgViewPlayer.image=UIImage(named: "ImgPlayer")
            }
//        if let imgStr = viewModel?.obj.awayTeamLogo{

        //print(viewModel!.player.playerName)
        lblName.text=viewModel?.player.playerName
        lblPosition.text=viewModel?.player.playerType.rawValue
        lblNum.text = viewModel?.player.playerNumber
        lblRate.text = viewModel?.player.playerRating
        
    }

}
