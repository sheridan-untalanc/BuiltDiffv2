//
//  GroupsCreateViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-03-31.
//

import UIKit
import FirebaseStorage

class GroupsCreateViewController: UIViewController {

    @IBOutlet var BackgroundBox: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var groupNameInput: UITextField!
    @IBOutlet var ImageSelector: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isHidden = true
        BackgroundBox.layer.cornerRadius = 25.0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func chooseImage(sender: AnyObject) {
        imageView.isHidden = false
        switch ImageSelector.selectedSegmentIndex {
        case 0:
          imageView.image = UIImage(named: "SoccerTeam")
        case 1:
          imageView.image = UIImage(named: "GymGroup")
        case 2:
          imageView.image = UIImage(named: "RunningGroup")
        default:
          imageView.image = UIImage(named: "SoccerTeam")
        }
    }
    
    @IBAction func onCreateGroup(_ sender: Any) {
        guard let groupName = groupNameInput.text, !groupName.isEmpty else {
            let alert = UIAlertController(title: "Error!", message: "One or more of the fields is empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let imageData = imageView.image?.jpegData(compressionQuality: 0.1) else {
            print("Could not get image!")
            return
        }
    
        FirebaseAccessLayer.UploadImage(imageData: imageData, fileName: groupName)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
