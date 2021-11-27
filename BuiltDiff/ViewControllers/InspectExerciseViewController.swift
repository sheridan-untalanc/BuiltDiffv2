//
//  InspectExerciseViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-11-23.
//

import UIKit

var groupListBuilder: Profile?

class InspectExerciseViewController: UIViewController {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var caloriesLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var typeImage: UIImageView!
    @IBAction func shareButton(_ sender: Any) {
        performSegue(withIdentifier: "viewGroups", sender: self)
    }
    
    override func viewDidLoad() {
        dateLabel.text = "Date Performed: \(workouts[workoutSelection][3])"
        typeLabel.text = workouts[workoutSelection][0]
        durationLabel.text = workouts[workoutSelection][1]
        caloriesLabel.text = workouts[workoutSelection][2]
        distanceLabel.text = workouts[workoutSelection][5]
        typeImage.image = UIImage(named: workouts[workoutSelection][4])!
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Task.init{
            groupListBuilder = try await Profile.GetProfile()
        }
    }
    
    @IBAction func unwindToExercisehistory(_ sender: Any) {
        performSegue(withIdentifier: "unwindToExerciseHistory", sender: self)
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }

}
