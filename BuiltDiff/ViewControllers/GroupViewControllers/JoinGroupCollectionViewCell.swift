//
//  JoinGroupCollectionViewCell.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-15.
//

import UIKit

class JoinGroupCollectionViewCell: UICollectionViewCell {
    static let identifier = "JoinGroupCollectionViewCell"
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupMemberCount: UILabel!
    @IBOutlet weak var groupDate: UILabel!
    
    func configure(name: String, members: String, date: String){
        groupName.text = name
        groupMemberCount.text = members
        groupDate.text = date
    }
}
