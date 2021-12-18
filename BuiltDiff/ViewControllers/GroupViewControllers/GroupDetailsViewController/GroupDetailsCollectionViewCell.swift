//
//  GroupDetailsCollectionViewCell.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-11-15.
//

import UIKit

class GroupDetailsCollectionViewCell: UICollectionViewCell {
    static let identifier = "GroupDetailsCollectionViewCell"
    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var numberOfTasksLabel: UILabel!
    
    func configure(workoutName: String, numOfTasks: String){
        workoutNameLabel.text = workoutName
        numberOfTasksLabel.text = "# of Tasks: \(numOfTasks)"
//        groupPicture.image = picture
    }
}
