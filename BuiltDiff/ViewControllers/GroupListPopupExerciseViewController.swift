//
//  GroupListPopupExerciseViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-11-24.
//

import UIKit

class GroupListPopupExerciseViewController: UIViewController {
    
    @IBOutlet weak var groupsCollectionView: UICollectionView!
    @IBOutlet var groupView: UIView!
    
    
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task.init{
            groupView.layer.cornerRadius = 20
            let groupIdList = groupListBuilder!.GroupList
            groups = try await Group.LoadAll(groupIds: groupIdList)
            groupsCollectionView.dataSource = self
            groupsCollectionView.delegate = self
            groupsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
            groupsCollectionView.reloadData()
        }
    }
}

extension GroupListPopupExerciseViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupListBuilder!.GroupList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupListPopupCollectionViewCell", for: indexPath) as! GroupListPopupCollectionViewCell
        cell.layer.cornerRadius = 10
        
        cell.configure(name: groups[indexPath.row].GroupName, description: groups[indexPath.row].GroupDescription)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let groupIdList = groupListBuilder!.GroupList
        FirebaseAccessLayer.PushExercise(groupId: groupIdList[indexPath.row], exercise: Exercise(originalUser: FirebaseAccessLayer.GetCurrentUserId(), date: workouts[workoutSelection][3], exerciseType: workouts[workoutSelection][0], distance: workouts[workoutSelection][5], duration: workouts[workoutSelection][1], calories: workouts[workoutSelection][2], imageName: workouts[workoutSelection][4])
        )
        let alert = UIAlertController(title: "Exercise Shared!", message: "Your exercise has been successfully shared with the group!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: finishAlert(alert:)))
        self.present(alert, animated: true, completion: nil)
    }
    
    func finishAlert(alert: UIAlertAction!)
    {
        performSegue(withIdentifier: "unwindToInspectExercise", sender: self)
    }
}

extension GroupListPopupExerciseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 244, height: 95)
    }
}
