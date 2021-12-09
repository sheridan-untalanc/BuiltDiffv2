//
//  SecondGroupViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-12.
//

import UIKit

class JoinGroupViewController: UIViewController {
    
    @IBOutlet weak var digitCodeLabel: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var baseView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
    }
    
    @IBAction func joinButtonTapped(_ sender: Any) {
        if digitCodeLabel.text == "" {
            let alert = UIAlertController(title: "Error!", message: "The text field cannot be empty!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        else{
            Task.init{
                let status = try await FirebaseAccessLayer.JoinGroup(groupId: digitCodeLabel.text!)
                if status == 0{
                    let alert = UIAlertController(title: "Success", message: "Joined group successfully!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                    groupBuilder = try await Profile.GetProfile()
                    self.present(alert, animated: true, completion: nil)
                    return
                } else if status == -2 {
                    let alert = UIAlertController(title: "Error", message: "This group does not exist!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                else if status == -1 {
                    let alert = UIAlertController(title: "Error", message: "You are already in this group!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }
        }
    }
    
}
