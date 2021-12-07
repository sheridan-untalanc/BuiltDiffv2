//
//  GroupListPopupCollectionViewCell.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-11-24.
//

import UIKit

class GroupListPopupCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var groupName: UILabel!
    @IBOutlet var groupDescription: UILabel!
    
    func configure(name: String, description: String){
            groupName.text = name
            groupDescription.text = description
            groupDescription.sizeToFit()
        }
    
}
