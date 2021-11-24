//
//  WorkoutDetailViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-11-23.
//

import UIKit

class WorkoutDetailViewController: UIViewController {
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var numOfTasksLabel: UILabel!
    
//    var groupDetailsViewController = GroupDetailsViewController()
    var workout : Workout?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.layer.cornerRadius = 20
        workoutNameLabel.text = workout?.Name
        numOfTasksLabel.text = "# of Tasks: \(workout?.WorkoutTasks.count ?? 0)"
    }

}
