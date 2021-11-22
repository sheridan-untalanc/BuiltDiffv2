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

class ExerciseViewController: UIViewController{
    
    @IBOutlet var collectionView: UICollectionView!
    let checkerInstance = AchievementChecker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }

    @IBAction func unwindToExerciseHome(_ sender: Any) {
        performSegue(withIdentifier: "unwindToExerciseHome", sender: self)
    }
}


extension ExerciseViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        checkerInstance.ExercisesCompleted(){ (completed) in
            workoutsCount = Int(completed)
            self.collectionView?.reloadData()
        }
        return workoutsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        checkerInstance.ExerciseList(){ (completed) in
            workouts = (completed)
            cell.configure(
                image: UIImage(named: workouts[indexPath.row][4])!,
                label: workouts[indexPath.row][0],
                date: workouts[indexPath.row][3],
                duration: workouts[indexPath.row][1],
                calories: workouts[indexPath.row][2])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }
}

extension ExerciseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 349, height: 115)
    }
}


