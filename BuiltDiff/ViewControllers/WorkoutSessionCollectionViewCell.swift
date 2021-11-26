//
//  WorkoutSessionCollectionViewCell.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-11-24.
//

import UIKit

class WorkoutSessionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var numOfTasksLabel: UILabel!
    
    
    func configure(name: String, numberOfTasks: String){
        workoutNameLabel.text = name
        numOfTasksLabel.text = numberOfTasks
        }
}
