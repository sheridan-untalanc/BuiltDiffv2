//
//  WatchInformationViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-11-18.
//
import UIKit

class WatchInformationViewController: UIViewController {

    @IBOutlet var ExerciseSelection: UIImageView!
    @IBOutlet var ExerciseActive: UIImageView!
    @IBOutlet var ExerciseEnd: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExerciseSelection.layer.cornerRadius = 5;
        ExerciseEnd.layer.cornerRadius = 5;
        ExerciseActive.layer.cornerRadius = 5;
        

        // Do any additional setup after loading the view.
    }
    @IBAction func unwindToExerciseHome(_ sender: Any) {
        performSegue(withIdentifier: "unwindToExerciseHome", sender: self)
    }

}
