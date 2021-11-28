//
//  ExerciseDetailViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-11-27.
//

import UIKit

class ExerciseDetailViewController: UIViewController {
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var exerciseDurationLabel: UILabel!
    @IBOutlet weak var exerciseCaloriesLabel: UILabel!
    @IBOutlet weak var exerciseDistanceLabel: UILabel!
    @IBOutlet weak var exerciseDateLabel: UILabel!
    
    var exercise: Exercise?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        baseView.layer.cornerRadius = 20
        Task.init{
            createdByLabel.text = "Created By: \(try await FirebaseAccessLayer.GetUsername(userId: exercise!.OriginalUser))"
        }
        exerciseNameLabel.text = exercise?.ExerciseType
        exerciseImage.image = UIImage(named: exercise!.ImageName)
        exerciseDurationLabel.text = exercise?.Duration
        exerciseCaloriesLabel.text = exercise?.Calories
        exerciseDistanceLabel.text = exercise?.Distance
        exerciseDateLabel.text = exercise?.Date
    }
}
