//
//  CreateExerciseCollectionViewCell.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-11-15.
//

import UIKit

class CreateExerciseCollectionViewCell: UICollectionViewCell {
    static let identifier = "CreateExerciseCollectionViewCell"
    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var caloriesBurntLabel: UILabel!
    @IBOutlet weak var exerciseDurationLabel: UILabel!
    
    func configure(workoutName: String, caloriesBurnt: String, exerciseDuration: String){
            workoutNameLabel.text = workoutName
            caloriesBurntLabel.text = caloriesBurnt
            exerciseDurationLabel.text = exerciseDuration
        }
}
