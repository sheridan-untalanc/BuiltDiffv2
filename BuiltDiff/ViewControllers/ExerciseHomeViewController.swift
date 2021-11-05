//
//  ExerciseHomeViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-11-05.
//

import UIKit

class ExerciseHomeViewController: UIViewController {

    @IBOutlet var FitnessImage: UIImageView!
    @IBOutlet var StartWorkout: UIImageView!
    @IBOutlet var CreateWorkout: UIImageView!
    @IBOutlet var ActivityHistory: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FitnessImage.layer.cornerRadius = 10
        StartWorkout.layer.cornerRadius = 10
        CreateWorkout.layer.cornerRadius = 10
        ActivityHistory.layer.cornerRadius = 10
        
    }
    
    
    
    @IBAction func FitnessSessionStart(_ sender: Any) {
        
    }
    
    @IBAction func WeightSessionStart(_ sender: Any) {
    }
    
    @IBAction func WeightSessionPlan(_ sender: Any) {
    }
    
    @IBAction func ActivityHistoryButton(_ sender: Any) {
    }
}
