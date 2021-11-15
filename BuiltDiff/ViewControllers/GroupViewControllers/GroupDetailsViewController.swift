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
    
    var groupName = ""
    var groupDescription = ""
    var memberCount = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        groupTitle.text = groupName
        groupDescriptionLabel.text = groupDescription
        groupImage.layer.cornerRadius = 50
        groupImage.layer.masksToBounds = true
        groupBackButton.layer.cornerRadius = 20
    }
    
    @IBAction func unwindToMyGroups(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMyGroups", sender: self)
        }

}
