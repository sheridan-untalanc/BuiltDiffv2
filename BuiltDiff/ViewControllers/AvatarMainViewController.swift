//
//  AvatarMainViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-04-08.
//

import UIKit

class AvatarMainViewController: UIViewController {
    @IBOutlet weak var customizationBackground: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        customizationBackground.layer.cornerRadius = 30
    }

}
