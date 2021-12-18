//
//  AchievementViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-10-16.
//

import UIKit

class AchievementViewController: UIViewController {

    let dataSource = ProfileViewController()
    
    @IBOutlet var DoneButton: UIButton!
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var lblGoal1: UILabel!
    @IBOutlet var lblGoal2: UILabel!
    @IBOutlet var lblGoal3: UILabel!
    @IBOutlet var lblProgress: UILabel!
    @IBOutlet var imgStar1: UIImageView!
    @IBOutlet var imgStar2: UIImageView!
    @IBOutlet var imgStar3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = achievementTitle
        lblDesc.text = achievementDesc
        lblGoal1.text = achievementGoal1
        lblGoal2.text = achievementGoal2
        lblGoal3.text = achievementGoal3
        if starsArray[whichStar][0] == 1{
            imgStar1.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
        }
        if starsArray[whichStar][1] == 1{
            imgStar2.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
        }
        if starsArray[whichStar][2] == 1{
            imgStar3.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
        }
        lblProgress.text = progress
            
    }
    
    @IBAction func backToProfile(_ sender: Any) {
        performSegue(withIdentifier: "unwindToProfile", sender: self)
    }
    
    
    
}
