//
//  GroupListPopupWorkoutsCollectionViewCell.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-11-27.
//

import UIKit

class GroupListPopupWorkoutsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var groupName: UILabel!
    @IBOutlet var groupDescription: UILabel!
    
    func configure(name: String, description: String){
            groupName.text = name
            groupDescription.text = description
            groupDescription .sizeToFit()
        }
}
