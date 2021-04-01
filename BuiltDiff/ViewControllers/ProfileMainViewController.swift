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
        
        let gesture = UIGestureRecognizer(target: self, action: #selector(didTapChangeProfilePicture))
        profilePicture.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapChangeProfilePicture(){
        presentPhotoActionSheet()
    }
}

extension ProfileMainViewController : UIImagePickerControllerDelegate{
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            
        }))
        
        present(actionSheet, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    }
}
