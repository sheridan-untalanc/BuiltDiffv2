//
//  LeaderboardTableViewCell.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-11-25.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {
    @IBOutlet weak var trophyImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userPoints: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        trophyImage.image = UIImage(named: "achievements-icon")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(picture: UIImage, name: String, points: Int){
        trophyImage.image = picture
        userName.text = name
        userPoints.text = ("\(points)")
    }

}
