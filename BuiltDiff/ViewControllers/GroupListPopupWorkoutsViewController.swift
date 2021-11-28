//
//  GroupListPopupWorkoutViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-11-27.
//

import UIKit

class GroupListPopupWorkoutsViewController: UIViewController {

    @IBOutlet var groupListCollectionView: UICollectionView!
    @IBOutlet var groupsView: UIView!
    
    var groups: [Group] = []
    var myWorkouts: [Workout] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Task.init{
            groupsView.layer.cornerRadius = 20
            myWorkouts = try await Workout.LoadAllUsersWorkouts()
            let groupIdList = groupListBuilder!.GroupList
            groups = try await Group.LoadAll(groupIds: groupIdList)
            groupListCollectionView.dataSource = self
            groupListCollectionView.delegate = self
            groupListCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
            groupListCollectionView.reloadData()
        }
    }

}

extension GroupListPopupWorkoutsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupListBuilder!.GroupList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupListPopupWorkoutsCollectionViewCell", for: indexPath) as! GroupListPopupWorkoutsCollectionViewCell
        cell.layer.cornerRadius = 10
        
        cell.configure(name: groups[indexPath.row].GroupName, description: groups[indexPath.row].GroupDescription)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let groupIdList = groupListBuilder!.GroupList
        FirebaseAccessLayer.PushGroupWorkout(workout: myWorkouts[selectedWorkout], groupId: groupIdList[indexPath.row])
        
        let alert = UIAlertController(title: "Workout Shared!", message: "Your workout has been successfully shared with the group!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: finishAlert(alert:)))
        self.present(alert, animated: true, completion: nil)
    }
    
    func finishAlert(alert: UIAlertAction!)
    {
        performSegue(withIdentifier: "unwindToWorkoutInspect", sender: self)
    }
}

extension GroupListPopupWorkoutsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 244, height: 95)
    }
}

