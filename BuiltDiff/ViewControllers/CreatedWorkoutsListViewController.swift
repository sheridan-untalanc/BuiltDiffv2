//
//  CreatedWorkoutsListViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-11-25.
//

import UIKit

class CreatedWorkoutsListViewController: UIViewController {
    @IBOutlet weak var workoutSessionCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutSessionCollectionView.dataSource = self
        workoutSessionCollectionView.delegate = self
        workoutSessionCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
    }
    
}

extension CreatedWorkoutsListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkoutSessionCollectionViewCell", for: indexPath) as! WorkoutSessionCollectionViewCell
        cell.layer.cornerRadius = 10
        
//        cell.configure(name: groups[indexPath.row].GroupName, description: groups[indexPath.row].GroupDescription)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("works")
    }
    
    
}

extension CreatedWorkoutsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 110)
    }
}
