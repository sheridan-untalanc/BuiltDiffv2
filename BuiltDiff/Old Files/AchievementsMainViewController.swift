//
//  AchievementsMainViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-04-08.
//

import UIKit

class AchievementsMainViewController: UIViewController {
    @IBOutlet weak var background1: UIImageView!
    @IBOutlet weak var background2: UIImageView!
    @IBOutlet weak var background3: UIImageView!
    @IBOutlet weak var background4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background1.layer.cornerRadius = 30
        background2.layer.cornerRadius = 30
        background3.layer.cornerRadius = 30
        background4.layer.cornerRadius = 30
    }
}
