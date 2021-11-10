//
//  ThirdGroupViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-14.
//

import UIKit

class CreateGroupViewController: UIViewController {
    @IBOutlet weak var groupProfileImage: UIImageView!
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var groupDescription: UITextField!
    @IBOutlet weak var groupSize: UISegmentedControl!
    @IBOutlet weak var groupCode: UILabel!
    @IBOutlet weak var createGroupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        groupProfileImage.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("didTapGroupImage"))
        groupProfileImage.addGestureRecognizer(tapRecognizer)
        groupProfileImage.layer.masksToBounds = true
        groupProfileImage.layer.cornerRadius = groupProfileImage.frame.height / 2
        groupProfileImage.layer.cornerRadius = groupProfileImage.frame.width / 2
        
        groupCode.text = "\(randomCode(digits: 6))"
        
        
    }

    @objc func didTapGroupImage(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func randomCode(digits: Int) -> String{
        var number = String()
        for _ in 1...digits {
            number += "\(Int.random(in: 1...9))"
        }
        return number
    }
    
    func finishAlert(alert: UIAlertAction!)
    {
        performSegue(withIdentifier: "unwindToGroupHome", sender: self)
    }
    
    @IBAction func createGroupTapped(_ sender: Any) {
        if groupName.text == "" || groupDescription.text == "" {
            let alert = UIAlertController(title: "Error!", message: "Please fill in all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        else{
            let newGroup = Group(groupName: groupName.text!, groupOwner: FirebaseAccessLayer.GetCurrentUserId(), saveToDatabase: true, groupDescription: groupDescription.text!)
            let alert = UIAlertController(title: "Success!", message: "Group created successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: finishAlert(alert:)))
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
}

extension CreateGroupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]as? UIImage{
            groupProfileImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
