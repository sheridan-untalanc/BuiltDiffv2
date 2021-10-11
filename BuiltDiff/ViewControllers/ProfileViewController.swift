//
//  ProfileMainViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-03-27.
//

import UIKit

class ProfileViewController: UIViewController{
    
    @IBOutlet weak var changePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changePicture.layer.cornerRadius = 50.0;
        changePicture.layer.masksToBounds = true;
        // Do any additional setup after loading the view.
//        changePicture.layer.masksToBounds = true
//        changePicture.layer.cornerRadius = changePicture.frame.height / 2
    }
    
    @IBAction func didTapImage(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]as? UIImage{
            changePicture.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
