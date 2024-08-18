//
//  FavoriteTableViewCell.swift
//  InstaSport
//
//  Created by Youssif Hany on 17/08/2024.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteImage: UIImageView!
    
    @IBOutlet weak var favoriteLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setRoundedForImgCell(myImg : favoriteImage)
        viewCellUI()
    }

    @IBAction func youtubeButton(_ sender: Any) {
        DispatchQueue.main.async {
            self.openYouTube()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var favCell : LeagueCD?{
        didSet{
            guard let favCell = favCell else{return}
            favoriteImage.kf.indicatorType = .activity
            favoriteImage.kf.setImage(with: URL(string: favCell.leagueLogo ?? "https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png"))
            favoriteLabel.text = favCell.leagueName
        }
    }
    
    func openYouTube() {
        UIApplication.shared.open(URL(string: ("https://www.youtube.com/@\(String(describing: favoriteLabel.text))"))!, options: [:], completionHandler: nil)
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
        favoriteLabel.text = title
        if check {
            if let imageUrl = URL(string: photo), let imageData = try? Data(contentsOf: imageUrl) {
                favoriteImage.image = UIImage(data: imageData)
            } else {
                favoriteImage.image = UIImage(named: photo)
            }
        } else {
            favoriteImage.image = UIImage(named: photo)
        }
    }
}
