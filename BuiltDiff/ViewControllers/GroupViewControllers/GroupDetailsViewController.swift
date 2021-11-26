//
//  GroupDetailsViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-11-12.
//

import UIKit

class GroupDetailsViewController: UIViewController {
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var groupDescriptionLabel: UILabel!
    @IBOutlet weak var groupBackButton: UIButton!
    @IBOutlet weak var groupExerciseCollectionView: UICollectionView!
    @IBOutlet weak var sharedWorkoutsCollectionView: UICollectionView!
    @IBOutlet weak var leaderboardImage: UIImageView!
    @IBOutlet weak var typeOfCollectionView: UISegmentedControl!
    
    var group: Group? = nil
    var groupWorkouts: [Workout] = []
    
//    var myGroupWorkouts = group?.Workouts
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GroupDetailsViewController.imageTapped(gesture:)))
        leaderboardImage.addGestureRecognizer(tapGesture)
        leaderboardImage.isUserInteractionEnabled = true
        groupTitle.text = group?.GroupName
        groupDescriptionLabel.text = group?.GroupDescription
        groupImage.layer.cornerRadius = 75
        groupImage.layer.masksToBounds = true
        groupBackButton.layer.cornerRadius = 20
        
        sharedWorkoutsCollectionView.delegate = self
        sharedWorkoutsCollectionView.dataSource = self
        groupExerciseCollectionView.delegate = self
        groupExerciseCollectionView.dataSource = self
        sharedWorkoutsCollectionView.isHidden = true
        groupExerciseCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        Task.init{
            FirebaseAccessLayer.GetGroupImage(ownerUid: group!.GroupOwner, completion: { image in
                DispatchQueue.main.async{
                    self.groupImage.image = image
                }
            })
        }
    }
    
    @IBAction func unwindToMyGroups(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMyGroups", sender: self)
        }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
            // if the tapped view is a UIImageView then set it to imageview
            if (gesture.view as? UIImageView) != nil {
                print("Image Tapped")
                //Here you can initiate your new ViewController
                performSegue(withIdentifier: "leaderboardSegue", sender: self)
            }
        }
    
    @IBAction func segmentChanged(_ sender: Any) {
        switch typeOfCollectionView.selectedSegmentIndex {
            case 0:
            groupExerciseCollectionView.isHidden = false
            sharedWorkoutsCollectionView.isHidden = true
            case 1:
            groupExerciseCollectionView.isHidden = true
            sharedWorkoutsCollectionView.isHidden = false
            default:
                break;
            }
    }
    

}

extension GroupDetailsViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.groupExerciseCollectionView{
            return group!.Workouts.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.groupExerciseCollectionView {
            let cell = groupExerciseCollectionView.dequeueReusableCell(withReuseIdentifier: "GroupDetailsCollectionViewCell", for: indexPath) as! GroupDetailsCollectionViewCell
                    cell.layer.cornerRadius = 10
                    cell.configure(workoutName: (group?.Workouts[indexPath.row].Name)!, numOfTasks: "\(group?.Workouts[indexPath.row].WorkoutTasks.count ?? 0)")
                    return cell
            }
            else {
                let cell2 = sharedWorkoutsCollectionView.dequeueReusableCell(withReuseIdentifier: "CreateExerciseCollectionViewCell", for: indexPath) as! CreateExerciseCollectionViewCell
                cell2.layer.cornerRadius = 10
//                cell2.configure(workoutName: workouts[indexPath.row][0], caloriesBurnt: workouts[indexPath.row][2], exerciseDuration: workouts[indexPath.row][1])
                return cell2
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.groupExerciseCollectionView{
            let vc = storyboard?.instantiateViewController(withIdentifier: "workoutDetailScene") as? WorkoutDetailViewController
            vc?.workout = group?.Workouts[indexPath.row]
            self.navigationController?.present(vc!, animated: true)
        }
    }
}

extension GroupDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 110)
    }
}
