//
//  InspectExerciseViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-11-23.
//

import UIKit

class InspectExerciseViewController: UIViewController {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var caloriesLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var typeImage: UIImageView!
    var selectedWorkout = ExerciseViewController()
    
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
    
    @IBAction func unwindToExercisehistory(_ sender: Any) {
        performSegue(withIdentifier: "unwindToExerciseHistory", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
