//
//  AvatarMainViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-04-01.
//

import UIKit

class AvatarMainViewController : UIViewController{
    @IBOutlet weak var customizationBackground: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customizationBackground.layer.cornerRadius = 30
        
    }
}
