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
        
        // Create a reference to the file you want to upload
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("images/\(groupName).jpg")

        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = imageRef.putData(imageData, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            print("Uh-oh, an error occurred getting the metadata")
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          imageRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
                print("Uh-oh, an error occurred getting the download URL")
              return
            }
          }
        }
        
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
