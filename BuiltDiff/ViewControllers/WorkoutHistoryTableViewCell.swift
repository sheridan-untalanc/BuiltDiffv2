//
//  WorkoutHistoryTableViewCell.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-12-07.
//

import UIKit

class WorkoutHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var workoutImage: UIImageView!
    @IBOutlet weak var workoutTitle: UILabel!
    @IBOutlet weak var workoutDate: UILabel!
    
    func configure(name: String, date: String, image: UIImage){
        workoutTitle.text = name
        workoutDate.text = "Performed on: \(date)"
        workoutImage.image = image
    }
}
