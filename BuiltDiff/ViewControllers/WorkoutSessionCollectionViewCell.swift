//
//  WorkoutSessionCollectionViewCell.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-11-24.
//

import UIKit

class WorkoutSessionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var workoutName: UILabel!
    @IBOutlet var workoutTaskCount: UILabel!
    
    func configure(name: String, numberOfTasks: String){
            workoutName.text = name
            workoutTaskCount.text = numberOfTasks
        }
}
