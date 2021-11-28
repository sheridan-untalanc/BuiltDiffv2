//
//  InspectWorkoutViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-11-27.
//

import UIKit

class InspectWorkoutViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var taskCollectionView: UICollectionView!
    
    @IBAction func unwindToWorkouts( _ seg: UIStoryboardSegue) {
    }
    
    var myWorkouts: [Workout] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task.init{
            myWorkouts = try await Workout.LoadAllUsersWorkouts()
            titleLabel.text = myWorkouts[selectedWorkout].Name
            taskCollectionView.dataSource = self
            taskCollectionView.delegate = self
            taskCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
            taskCollectionView.reloadData()
        }
        
    }
}

extension InspectWorkoutViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myWorkouts[selectedWorkout].WorkoutTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InspectWorkoutCollectionViewCell", for: indexPath) as! InspectWorkoutCollectionViewCell
        cell.layer.cornerRadius = 16
        cell.backgroundColor = UIColor.systemGray6
        cell.configure(name: myWorkouts[selectedWorkout].WorkoutTasks[indexPath.row].Name, description: myWorkouts[selectedWorkout].WorkoutTasks[indexPath.row].Description, sets: "Sets: \(myWorkouts[selectedWorkout].WorkoutTasks[indexPath.row].Sets)", reps: "Reps: \(myWorkouts[selectedWorkout].WorkoutTasks[indexPath.row].Reps)")
        
        return cell
    }
}

extension InspectWorkoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 94)
    }
}
