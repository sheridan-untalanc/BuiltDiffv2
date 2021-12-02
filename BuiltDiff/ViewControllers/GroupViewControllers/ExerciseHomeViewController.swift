//
//  ExerciseHomeViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-11-05.
//
import UIKit

var groupListBuilder: Profile?

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
    
    override func viewWillAppear(_ animated: Bool) {
        Task.init{
            groupListBuilder = try await Profile.GetProfile()
        }
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
    @IBAction func didTapButton(){
        let alertController = UIAlertController(title: "", message: "What would you like to do?", preferredStyle: .actionSheet)
            
            let exerciseButton = UIAlertAction(title: "View Exercise History", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "exerciseHistorySegue", sender: self)
                
            })
            
            let  workoutButton = UIAlertAction(title: "View Workout History", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "workoutHistorySegue", sender: self)
            })
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            })
    
            alertController.addAction(exerciseButton)
            alertController.addAction(workoutButton)
            alertController.addAction(cancelButton)
            
            self.navigationController?.present(alertController, animated: true, completion: nil)
    }
}
