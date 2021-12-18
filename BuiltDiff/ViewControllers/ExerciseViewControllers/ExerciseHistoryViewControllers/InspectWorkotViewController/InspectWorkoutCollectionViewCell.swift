//
//  InspectWorkoutCollectionViewCell.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-11-27.
//

import UIKit

class InspectWorkoutCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var taskTitle: UILabel!
    @IBOutlet var taskDescription: UILabel!
    @IBOutlet var taskSets: UILabel!
    @IBOutlet var taskReps: UILabel!
    
    func configure(name: String, description: String, sets: String, reps: String){
        taskTitle.text = name
        taskDescription.text = description
        taskSets.text = sets
        taskReps.text = reps
        }
    
}
