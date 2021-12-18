//
//  CompleteWorkoutViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-11-27.
//

import UIKit

class CompleteWorkoutViewController: UIViewController {
    
    @IBOutlet var titleText: UILabel!
    @IBOutlet var completeWorkoutCollectionView: UICollectionView!
    
    var myWorkouts: [Workout] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task.init{
            myWorkouts = try await Workout.LoadAllUsersWorkouts()
            titleText.text = myWorkouts[selectedWorkout].Name
            completeWorkoutCollectionView.dataSource = self
            completeWorkoutCollectionView.delegate = self
            completeWorkoutCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
            completeWorkoutCollectionView.reloadData()
        }

    }
    @IBAction func addToWorkouts(_ sender: Any) {
        FirebaseAccessLayer.PushCompletedWorkout(workout: myWorkouts[selectedWorkout])
        performSegue(withIdentifier: "unwindToWorkoutInspect", sender: self)
    }
}

extension CompleteWorkoutViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myWorkouts[selectedWorkout].WorkoutTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompleteWorkoutCollectionViewCell", for: indexPath) as! CompleteWorkoutCollectionViewCell
        cell.layer.cornerRadius = 16
        cell.backgroundColor = UIColor.systemGray6
        cell.configure(name: myWorkouts[selectedWorkout].WorkoutTasks[indexPath.row].Name, description: myWorkouts[selectedWorkout].WorkoutTasks[indexPath.row].Description, sets: "Sets: \(myWorkouts[selectedWorkout].WorkoutTasks[indexPath.row].Sets)", reps: "Reps: \(myWorkouts[selectedWorkout].WorkoutTasks[indexPath.row].Reps)")
        return cell
    }
}

extension CompleteWorkoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 134)
    }
}
