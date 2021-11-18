//
//  ListGroupsCollectionViewCell.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-11-09.
//

import UIKit

class ListGroupsCollectionViewCell: UICollectionViewCell {
    static let identifier = "ListGroupsCollectionViewCell"
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    @IBOutlet weak var groupDate: UILabel!
    
//    func configure(name: String, members: String, date: String){
//        groupName.text = name
//        groupMemberCount.text = members
//        groupDate.text = date
//    }
    
    func configure(name: String, description: String){
        groupName.text = name
        groupDescription.text = description
    }
}
