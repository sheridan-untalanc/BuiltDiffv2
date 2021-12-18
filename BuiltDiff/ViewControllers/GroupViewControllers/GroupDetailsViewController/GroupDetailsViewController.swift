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
    @IBOutlet weak var copyIdLabel: UIButton!
    @IBOutlet weak var challengesView: UIView!
    @IBOutlet weak var groupEditButton: UIButton!
    @IBOutlet weak var challengeTitleLabel: UILabel!
    @IBOutlet weak var challengeDeadlineLabel: UILabel!
    @IBOutlet weak var challengeMetricLabel: UILabel!
    @IBOutlet weak var challengePointsLabel: UILabel!
    @IBOutlet weak var challengeProgressBar: UIProgressView!
    @IBOutlet var challengeOverlapView: UIView!
    @IBOutlet var challengeOverlapLabel: UILabel!
    
    let metricFetcher = AchievementChecker()
    var group: Group? = nil
    var challenge: Challenge? = nil
    var groupWorkouts: [Workout] = []
    var content: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GroupDetailsViewController.imageTapped(gesture:)))
        leaderboardImage.addGestureRecognizer(tapGesture)
        leaderboardImage.isUserInteractionEnabled = true
        challengesView.layer.cornerRadius = 10
        challengesView.layer.shadowColor = UIColor.black.cgColor
        challengesView.layer.shadowOpacity = 1
        challengesView.layer.shadowOffset = CGSize(width: 0, height: 1)
        challengesView.layer.shadowRadius = 1
        
        groupEditButton.isHidden = true
        if group?.GroupOwner == FirebaseAccessLayer.GetCurrentUserId(){
            groupEditButton.isHidden = false
        }
        
        groupTitle.text = group?.GroupName
        groupDescriptionLabel.text = group?.GroupDescription
        groupImage.layer.cornerRadius = 50
        groupImage.layer.masksToBounds = true
        groupBackButton.layer.cornerRadius = 20
        
        sharedWorkoutsCollectionView.delegate = self
        sharedWorkoutsCollectionView.dataSource = self
        
        groupExerciseCollectionView.delegate = self
        groupExerciseCollectionView.dataSource = self
        groupExerciseCollectionView.isHidden = true
        groupExerciseCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        Task.init{
            challenge = try await FirebaseAccessLayer.GetChallenge(groupId: group!.GroupId)
            DispatchQueue.main.async {
                if self.challenge?.ExerciseType != "N/A"{
                    self.challengeOverlapView.isHidden = true
                    self.challengeOverlapLabel.isHidden = true
                }
                self.challengeTitleLabel.text = self.challenge?.ExerciseType
                if self.challenge?.Metric == "Calories"{
                    self.challengeMetricLabel.text = "Burn \(self.challenge?.Goal ?? "5") Calories"
                } else if self.challenge?.Metric == "Duration (min)"{
                    self.challengeMetricLabel.text = "Complete \(self.challenge?.Goal  ?? "5") minutes"
                } else{
                    self.challengeMetricLabel.text = "Travel \(self.challenge?.Goal ?? "5") km"
                }
                self.challengeDeadlineLabel.text = self.challenge?.EndDate
                self.challengePointsLabel.text = "+\(self.challenge?.Points ?? 0) Points"
                if self.challenge?.ExerciseType != "N/A"{
                    self.metricFetcher.getValueForMetric(challengePassed: self.challenge!){ (completion) in
                        let totalMetric = completion
                        if totalMetric > Double(self.challenge!.Goal)!{
                            self.challengeProgressBar.setProgress(1, animated: true)
                            Task.init{
                                try await FirebaseAccessLayer.PushPoints(groupId: self.group!.GroupId, points: self.challenge!.Points)
                            }
                        } else {
                            self.challengeProgressBar.setProgress(Float((totalMetric/Double(self.challenge!.Goal)!)*100), animated: false)
                        }
                        
                    }
                }
            }
        }
        
        Task.init{
            FirebaseAccessLayer.GetGroupImage(ownerUid: group!.GroupOwner, completion: { image in
                DispatchQueue.main.async{
                    self.groupImage.image = image
                }
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Task.init{
            challenge = try await FirebaseAccessLayer.GetChallenge(groupId: group!.GroupId)
            DispatchQueue.main.async {
                if self.challenge?.ExerciseType != "N/A"{
                    self.challengeOverlapView.isHidden = true
                    self.challengeOverlapLabel.isHidden = true
                }
                self.challengeTitleLabel.text = self.challenge?.ExerciseType
                if self.challenge?.Metric == "Calories"{
                    self.challengeMetricLabel.text = "Burn \(self.challenge?.Goal ?? "5") Calories"
                } else if self.challenge?.Metric == "Duration (min)"{
                    self.challengeMetricLabel.text = "Complete \(self.challenge?.Goal  ?? "5") minutes"
                } else{
                    self.challengeMetricLabel.text = "Travel \(self.challenge?.Goal ?? "5") km"
                }
                self.challengeDeadlineLabel.text = self.challenge?.EndDate
                self.challengePointsLabel.text = "+\(self.challenge?.Points ?? 0) Points"
                if self.challenge?.ExerciseType != "N/A"{
                    self.metricFetcher.getValueForMetric(challengePassed: self.challenge!){ (completion) in
                        let totalMetric = completion
                        if totalMetric > Double(self.challenge!.Goal)!{
                            self.challengeProgressBar.setProgress(1, animated: true)
                            Task.init{
                                try await FirebaseAccessLayer.PushPoints(groupId: self.group!.GroupId, points: self.challenge!.Points)
                            }
                        } else {
                            self.challengeProgressBar.setProgress(Float((totalMetric/Double(self.challenge!.Goal)!)*100), animated: true)
                        }
                        
                    }
                }
            }
        }
    }
    
    @IBAction func unwindToMyGroups(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMyGroups", sender: self)
        }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
    @IBAction func createGroupChallenge(_ sender: Any) {
        self.challengeOverlapView.isHidden = true
        self.challengeOverlapLabel.isHidden = true
        let vc = storyboard?.instantiateViewController(withIdentifier: "createChallengeScene") as? CreateGroupChallengeViewController
        vc?.group = group
        self.navigationController?.show(vc!, sender: self)
    }
    
    
    @IBAction func copyGroupId(_ sender: Any) {
        UIPasteboard.general.string = group?.GroupId
        content = UIPasteboard.general.string
        print(content!)
        let alert = UIAlertController(title: "Copy Id", message: "Group Id copied successfully! Share with friends to let them join!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
            // if the tapped view is a UIImageView then set it to imageview
            if (gesture.view as? UIImageView) != nil {
                let vc = storyboard?.instantiateViewController(withIdentifier: "leaderboardScreen") as? LeaderboardViewController
                vc?.groupIdNumber = group!
                self.navigationController?.present(vc!, animated: true)
//                performSegue(withIdentifier: "leaderboardSegue", sender: self)
            }
        }
    
    @IBAction func segmentChanged(_ sender: Any) {
        switch typeOfCollectionView.selectedSegmentIndex {
            case 0:
            groupExerciseCollectionView.isHidden = true
            sharedWorkoutsCollectionView.isHidden = false
            case 1:
            groupExerciseCollectionView.isHidden = false
            sharedWorkoutsCollectionView.isHidden = true
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
        return group!.Exercises.count
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
                cell2.configure(workoutName: (group?.Exercises[indexPath.row].ExerciseType)!, caloriesBurnt: (group?.Exercises[indexPath.row].Calories)!, exerciseDuration: (group?.Exercises[indexPath.row].Duration)!)
                return cell2
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.groupExerciseCollectionView{
            let vc = storyboard?.instantiateViewController(withIdentifier: "workoutDetailScene") as? WorkoutDetailViewController
            vc?.workout = group?.Workouts[indexPath.row]
            self.navigationController?.present(vc!, animated: true)
        }
        else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "exerciseDetailScene") as? ExerciseDetailViewController
            vc?.exercise = group?.Exercises[indexPath.row]
            self.navigationController?.present(vc!, animated: true)
        }
    }
}

extension GroupDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 110)
    }
}
