//
//  CreateExerciseCollectionViewCell.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-11-15.
//

import UIKit

class CreateExerciseCollectionViewCell: UICollectionViewCell {
    static let identifier = "CreateExerciseCollectionViewCell"
    
    @IBOutlet var myCalories: UILabel!
    @IBOutlet var myDuration: UILabel!
    @IBOutlet var myType: UILabel!
    @IBOutlet var myDate: UILabel!
    
    func configure(){
            myType.text = "label"
            myDate.text = "date"
            myDuration.text = "duration"
            myCalories.text = "calories"
        }
}
