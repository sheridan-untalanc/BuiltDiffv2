//
//  CreatedWorkoutsListViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-11-25.
//

import UIKit

var selectedWorkout = 0

class CreatedWorkoutsListViewController: UIViewController {
    @IBOutlet weak var workoutSessionCollectionView: UICollectionView!
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
    var myWorkouts: [Workout] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task.init{
            myWorkouts = try await Workout.LoadAllUsersWorkouts()
            workoutSessionCollectionView.dataSource = self
            workoutSessionCollectionView.delegate = self
            workoutSessionCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
            workoutSessionCollectionView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        Task.init{
            workoutSessionCollectionView.reloadData()
        }
    }
    
}

extension CreatedWorkoutsListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myWorkouts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkoutSessionCollectionViewCell", for: indexPath) as! WorkoutSessionCollectionViewCell
        cell.layer.cornerRadius = 16
        cell.backgroundColor = UIColor.systemGray5
        
        cell.configure(name: myWorkouts[indexPath.row].Name, numberOfTasks: "Contains \(myWorkouts[indexPath.row].WorkoutTasks.count) Tasks")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedWorkout = indexPath.row
        performSegue(withIdentifier: "WorkoutDetails", sender: self)
    }
    
    
}

extension CreatedWorkoutsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 73)
    }
}
