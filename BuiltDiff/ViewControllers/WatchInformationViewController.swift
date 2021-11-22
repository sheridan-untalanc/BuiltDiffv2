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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
