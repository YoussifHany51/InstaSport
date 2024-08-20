//
//  LeaguesTableViewCell.swift
//  InstaSport
//
//  Created by Youssif Hany on 12/08/2024.
//

import UIKit
import Kingfisher
class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var leagueImageLabel: UIImageView!
    
    @IBOutlet weak var leagueTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius=20
        view.layer.borderWidth=2
        view.layer.borderColor=UIColor.clear.cgColor
        setRoundedForImgCell(myImg : leagueImageLabel)
        viewCellUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func leagueYoutubeBtn(_ sender: Any) {
        DispatchQueue.main.async {
            self.openYouTube()
        }
    }
    
    func openYouTube() {
        UIApplication.shared.open(URL(string: ("https://www.youtube.com/@\(String(describing: leagueTitleLabel.text))"))!, options: [:], completionHandler: nil)
    }

    func setRoundedForImgCell(myImg : UIImageView){
        let saveCenter = myImg.center
        let newFrame:CGRect = CGRect(origin: CGPoint(x: myImg.frame.origin.x,y : myImg.frame.origin.y), size: CGSize(width: myImg.frame.size.width - 20, height: myImg.frame.size.height - 20))
        myImg.layer.cornerRadius = myImg.frame.height / 2.2
        myImg.frame = newFrame;
        myImg.center = saveCenter
        myImg.clipsToBounds = true
    }
    func viewCellUI(){
        self.layer.shadowColor = UIColor.lightGray.cgColor
        //for actual cell
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.50
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        self.clipsToBounds = false
        self.contentView.layer.masksToBounds = true
    }
    
    func setUpLeagueCell(title:String,photo:String,check:Bool){
        if check{
            if let url = URL(string: photo){
                leagueImageLabel.kf.setImage(with: url)
            }
        }else{
            leagueImageLabel.image=UIImage(named: photo)
        }
        leagueTitleLabel.text = title
    }
}
