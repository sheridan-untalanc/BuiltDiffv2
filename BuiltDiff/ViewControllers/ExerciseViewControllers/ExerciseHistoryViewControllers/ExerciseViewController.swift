//
//  ExerciseViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-02.
//

import UIKit
import HealthKitUI
import HealthKit

let healthKitStore:HKHealthStore = HKHealthStore()
var workouts = [[String]]()
var workoutsCount = 0
var reloadCheck = 0
var workoutSelection = 0

class ExerciseViewController: UIViewController{
    
    @IBOutlet var collectionView: UICollectionView!
    let checkerInstance = AchievementChecker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkerInstance.ExerciseList(){ (completed) in
            workouts = (completed)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        reloadCheck = 0

    }
    
    @IBAction func backToAExerciseHome(_ sender: Any) {
        performSegue(withIdentifier: "unwindToExerciseHome", sender: self)
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
}


extension ExerciseViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            checkerInstance.ExercisesCompleted(){ (completed) in
                workoutsCount = Int(completed)
                if reloadCheck < 5 {
                    self.collectionView?.reloadData()
                    reloadCheck += 1
                }
            }
            return workoutsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
                cell.configure(
                    image: UIImage(named: workouts[indexPath.row][4])!,
                    label: workouts[indexPath.row][0],
                    date: workouts[indexPath.row][3],
                    duration: workouts[indexPath.row][1],
                    calories: workouts[indexPath.row][2])
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            workoutSelection = indexPath.row
            performSegue(withIdentifier: "inspectExercise", sender: self)
    }
}

extension ExerciseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 349, height: 115)
    }
}


