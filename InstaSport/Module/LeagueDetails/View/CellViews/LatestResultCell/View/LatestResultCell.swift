//
//  LatestResultCell.swift
//  InstaSport
//
//  Created by zyad Baset on 16/08/2024.
//

import UIKit
import Kingfisher
class LatestResultCell: UICollectionViewCell {
    @IBOutlet weak var lblAwayTeam: UILabel!
    @IBOutlet weak var imgViewAwayTeam: UIImageView!
    @IBOutlet weak var lblStadium: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblEventTime: UILabel!
    @IBOutlet weak var lblEventDate: UILabel!
    @IBOutlet weak var lblHomeTeam: UILabel!
    @IBOutlet weak var imgViewHomeTeam: UIImageView!
    var viewModel:LatestResultViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    func putData(){
        if let imgStr = viewModel?.obj.homeTeamLogo{
            if let url = URL(string:imgStr){
                imgViewHomeTeam.kf.setImage(with: url)
            }else{
                imgViewHomeTeam.image=UIImage(named: "imgFB")
            }}else{
                imgViewHomeTeam.image=UIImage(named: "imgFB")
            }
//        if let imgStr = viewModel?.obj.awayTeamLogo{
        if let imgStr = viewModel?.obj.awayTeamLogo{
            if let url = URL(string:imgStr){
                imgViewAwayTeam.kf.setImage(with: url)
            }else{
                imgViewAwayTeam.image=UIImage(named: "imgFB")
            }}else{
                imgViewAwayTeam.image=UIImage(named: "imgFB")
            }

        lblAwayTeam.text=viewModel?.obj.eventAwayTeam
        lblHomeTeam.text=viewModel?.obj.eventHomeTeam
        lblStadium.text=viewModel?.obj.eventStadium
        lblScore.text=viewModel?.obj.eventFinalResult
        lblEventDate.text=viewModel?.obj.eventDate
        lblEventTime.text=viewModel?.obj.eventTime
    }

}
