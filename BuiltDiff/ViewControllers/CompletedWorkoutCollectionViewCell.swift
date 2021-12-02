//
//  CompletedWorkoutCollectionViewCell.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-12-01.
//

import UIKit

class CompletedWorkoutCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var workoutTitle: UILabel!
    @IBOutlet var workoutDate: UILabel!
    
    func configure(name: String, date: String){
        workoutTitle.text = name
        workoutDate.text = "Performed on: \(date)"
    }
    
}
