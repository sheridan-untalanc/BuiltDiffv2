//
//  GroupViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-02.
//

import UIKit

var groupBuilder: Profile?

class GroupViewController: UIViewController, UIActionSheetDelegate {
    
    @IBOutlet weak var groupImage1: UIView!
    @IBOutlet weak var inviteButton: UIButton!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Task.init{
            groupBuilder = try await Profile.GetProfile()
        }
    }
    
    @IBAction func unwindToGroupHome( _ seg: UIStoryboardSegue){
            
        }
    
    @IBAction func didTapButton(){
        let alertController = UIAlertController(title: "", message: "What would you like to do?", preferredStyle: .actionSheet)
            
            let createButton = UIAlertAction(title: "Create Group", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "createGroupSegue", sender: self)
                
            })
            
            let  joinButton = UIAlertAction(title: "Join a Group", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "joinGroupSegue", sender: self)
            })
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
                print("Cancel button tapped")
            })
    
            alertController.addAction(createButton)
            alertController.addAction(joinButton)
            alertController.addAction(cancelButton)
            
            self.navigationController?.present(alertController, animated: true, completion: nil)
    }
}
