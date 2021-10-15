//
//  AchievementsCollectionViewCell.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-14.
//

import UIKit

class AchievementsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var trophyImage: UIImageView!
    @IBOutlet weak var firstStarImage: UIImageView!
    @IBOutlet weak var secondStarImage: UIImageView!
    @IBOutlet weak var thirdStarImage: UIImageView!
    @IBOutlet weak var achievementLabel: UILabel!
    
    func configure(trophy: UIImage, star1: UIImage, star2: UIImage, star3: UIImage, title: String){
        trophyImage.image = trophy
        firstStarImage.image = star1
        secondStarImage.image = star2
        thirdStarImage.image = star3
        achievementLabel.text = title
    }
    
    
    
}
