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
    
    @IBOutlet var typeOfCollectionView: UISegmentedControl!
    let checkerInstance = AchievementChecker()
    var myWorkouts: [(workoutId: String, workoutName: String, dateCompleted: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkerInstance.ExerciseList(){ (completed) in
            workouts = (completed)
        }
//        workoutColletionView.isHidden = true
        Task.init{
            myWorkouts = try await FirebaseAccessLayer.GetAllUserCompletedWorkouts()
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.collectionViewLayout = UICollectionViewFlowLayout()
//            workoutColletionView.dataSource = self
//            workoutColletionView.delegate = self
//            workoutColletionView.collectionViewLayout = UICollectionViewLayout()
            reloadCheck = 0
            collectionView.reloadData()
//            workoutColletionView.reloadData()
        }
    }
    
    @IBAction func historySelector(_ sender: Any) {
        switch typeOfCollectionView.selectedSegmentIndex {
            case 0:
//            workoutColletionView.isHidden = true
            collectionView.isHidden = false
            case 1:
//            workoutColletionView.isHidden = false
            collectionView.isHidden = true
            default:
                break;
            }
    }
    

    @IBAction func unwindToExerciseHome(_ sender: Any) {
        performSegue(withIdentifier: "unwindToExerciseHome", sender: self)
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
}


extension ExerciseViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView{
            checkerInstance.ExercisesCompleted(){ (completed) in
                workoutsCount = Int(completed)
                if reloadCheck < 5 {
                    self.collectionView?.reloadData()
                    reloadCheck += 1
                }
            }
            return workoutsCount
        }
        return myWorkouts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
                cell.configure(
                    image: UIImage(named: workouts[indexPath.row][4])!,
                    label: workouts[indexPath.row][0],
                    date: workouts[indexPath.row][3],
                    duration: workouts[indexPath.row][1],
                    calories: workouts[indexPath.row][2])
            return cell
        }else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkoutHistoryCollectionViewCell", for: indexPath) as! WorkoutHistoryCollectionViewCell
//            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView{
            workoutSelection = indexPath.row
            performSegue(withIdentifier: "inspectExercise", sender: self)
        }
    }
}

extension ExerciseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 349, height: 115)
    }
}


