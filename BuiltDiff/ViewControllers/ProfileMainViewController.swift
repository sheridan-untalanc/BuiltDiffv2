//
//  ProfileMainViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-03-27.
//

import UIKit

class ProfileMainViewController: UIViewController, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var backgroundFill: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var backgroundMedal: UIImageView!
    @IBOutlet weak var exercisesBackground: UIImageView!
    
//    let profileVC : UIViewController = ProfileMainViewController()
    
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
    
    @IBAction func displayActionSheet(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let profilePictureAction = UIAlertAction(title: "Change Profile Picture", style: .default, handler: {action in
            print("Tapped")
        })
        let customizeAvatarAction = UIAlertAction(title: "Customize Avatar", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                
        optionMenu.addAction(profilePictureAction)
        optionMenu.addAction(customizeAvatarAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
}
