//
//  GroupViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-02.
//

import UIKit

class GroupViewController: UIViewController, UIActionSheetDelegate {
    
    @IBOutlet weak var groupImage1: UIView!
    @IBOutlet weak var inviteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func didTapButton(){
        let alertController = UIAlertController(title: "", message: "What would you like to do?", preferredStyle: .actionSheet)
            
            let sendButton = UIAlertAction(title: "Create Group", style: .default, handler: { (action) -> Void in
                
            })
            
            let  deleteButton = UIAlertAction(title: "Join a Group", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "joinGroupSegue", sender: self)
            })
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
                print("Cancel button tapped")
            })
    
            alertController.addAction(sendButton)
            alertController.addAction(deleteButton)
            alertController.addAction(cancelButton)
            
            self.navigationController?.present(alertController, animated: true, completion: nil)
    }
}
