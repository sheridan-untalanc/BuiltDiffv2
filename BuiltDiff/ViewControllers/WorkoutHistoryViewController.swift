//
//  WorkoutHistoryViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-12-01.
//

import UIKit

class WorkoutHistoryViewController: UIViewController {

    @IBOutlet var workoutCollectionView: UICollectionView!
    var myWorkouts: [(workoutId: String, workoutName: String, dateCompleted: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task.init{
            myWorkouts = try await FirebaseAccessLayer.GetAllUserCompletedWorkouts()
            workoutCollectionView.dataSource = self
            workoutCollectionView.delegate = self
            workoutCollectionView.collectionViewLayout = UICollectionViewLayout()
            workoutCollectionView.reloadData()
        }

    }
    @IBAction func backToAExerciseHome(_ sender: Any) {
        performSegue(withIdentifier: "unwindToExerciseHome", sender: self)
    }

}


extension WorkoutHistoryViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myWorkouts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompletedWorkoutCollectionViewCell", for: indexPath) as! CompletedWorkoutCollectionViewCell
            cell.configure(name: myWorkouts[indexPath.row].workoutName, date: myWorkouts[indexPath.row].dateCompleted)
            return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension WorkoutHistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 349, height: 115)
    }
}
