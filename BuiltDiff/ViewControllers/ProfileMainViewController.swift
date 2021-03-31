//
//  ProfileMainViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-03-27.
//

import UIKit

class ProfileMainViewController: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var backgroundFill: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var backgroundMedal: UIImageView!
    @IBOutlet weak var exercisesBackground: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        profilePicture.layer.cornerRadius = profilePicture.bounds.width/2
        profilePicture.layer.masksToBounds = true
        backgroundFill.layer.cornerRadius = backgroundFill.bounds.width/2
        profilePicture.layer.masksToBounds = true
        backgroundMedal.layer.cornerRadius = 30
        exercisesBackground.layer.cornerRadius = 30
    }
}
