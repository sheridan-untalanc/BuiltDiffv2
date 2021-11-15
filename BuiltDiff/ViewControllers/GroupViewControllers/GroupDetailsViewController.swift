//
//  GroupDetailsViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-11-12.
//

import UIKit

class GroupDetailsViewController: UIViewController {
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var groupMemberCount: UILabel!
    @IBOutlet weak var groupDescriptionLabel: UILabel!
    @IBOutlet weak var groupBackButton: UIButton!
    
    var group: Group? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        groupTitle.text = group?.GroupName
        groupDescriptionLabel.text = group?.GroupDescription
        groupImage.layer.cornerRadius = 50
        groupImage.layer.masksToBounds = true
        groupBackButton.layer.cornerRadius = 20
        Task.init{
            FirebaseAccessLayer.GetGroupImage(ownerUid: group!.GroupOwner, completion: { image in
                DispatchQueue.main.async{
                    self.groupImage.image = image
                }
            })
        }
    }
    
    @IBAction func unwindToMyGroups(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMyGroups", sender: self)
        }

}
