//
//  ProfileMainViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-03-27.
//

import UIKit

var achievementTitle = ""
var achievementDesc = ""
var starsArray = [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]]
var achievementGoal1 = ""
var achievementGoal2 = ""
var achievementGoal3 = ""
var progress = ""
var progressValues = [0.0,0.0,0.0,0.0,0.0]
var whichStar = 0

class ProfileViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var changePicture: UIImageView!
    let checkerInstance = AchievementChecker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        changePicture.layer.cornerRadius = 50.0;
        changePicture.layer.masksToBounds = true;

        // Do any additional setup after loading the view.
//        changePicture.layer.masksToBounds = true
//        changePicture.layer.cornerRadius = changePicture.frame.height / 2
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    @IBAction func didTapImage(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func unwindToProfile( _ seg: UIStoryboardSegue){
        
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]as? UIImage{
            changePicture.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AchievementsCollectionViewCell", for: indexPath) as! AchievementsCollectionViewCell
        
        let completedStar = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
        let emptyStar = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
            
        completedStar?.withTintColor(.systemOrange)
        
        if(indexPath.row == 0){
            checkerInstance.ExercisesCompleted(){ (completed) in
                progressValues[indexPath.row] = Double(completed)
                var stars = [emptyStar,emptyStar,emptyStar]
                if (completed >= 5 && completed < 10){
                    stars = [completedStar,emptyStar,emptyStar]
                    starsArray[indexPath.row] = [1,0,0]
                } else if(completed >= 10 && completed < 20){
                    stars = [completedStar,completedStar,emptyStar]
                    starsArray[indexPath.row] = [1,1,0]
                } else if(completed >= 20 ){
                    stars = [completedStar,completedStar,completedStar]
                    starsArray[indexPath.row] = [1,1,1]
                }
                cell.configure(trophy: UIImage(named: "achievements-icon")!, star1: stars[0]!, star2: stars[1]!, star3: stars[2]!, title: "Sticking With It")
            }
        }else if(indexPath.row == 1){
            checkerInstance.MarathonRunner(){ (MarathonCompleted) in
                progressValues[indexPath.row] = Double(MarathonCompleted)
                var stars = [emptyStar,emptyStar,emptyStar]
                if (MarathonCompleted >= 1 && MarathonCompleted < 2){
                    stars = [completedStar,emptyStar,emptyStar]
                    starsArray[indexPath.row] = [1,0,0]
                } else if(MarathonCompleted >= 2 && MarathonCompleted < 3){
                    stars = [completedStar,completedStar,emptyStar]
                    starsArray[indexPath.row] = [1,1,0]
                } else if(MarathonCompleted >= 3 ){
                    stars = [completedStar,completedStar,completedStar]
                    starsArray[indexPath.row] = [1,1,1]
                }
                cell.configure(trophy: UIImage(named: "achievements-icon")!, star1: stars[0]!, star2: stars[1]!, star3: stars[2]!, title: "Marathon Runner")
            }
        }else if(indexPath.row == 2){
            checkerInstance.TotalDuration(){ (totalDuration) in
                progressValues[indexPath.row] = Double(totalDuration)
                var stars = [emptyStar,emptyStar,emptyStar]
                if (totalDuration >= 1.0 && totalDuration < 2.5){
                    stars = [completedStar,emptyStar,emptyStar]
                    starsArray[indexPath.row] = [1,0,0]
                } else if(totalDuration >= 2.5 && totalDuration < 5.0){
                    stars = [completedStar,completedStar,emptyStar]
                    starsArray[indexPath.row] = [1,1,0]
                } else if(totalDuration >= 5 ){
                    stars = [completedStar,completedStar,completedStar]
                    starsArray[indexPath.row] = [1,1,1]
                }
                cell.configure(trophy: UIImage(named: "achievements-icon")!, star1: stars[0]!, star2: stars[1]!, star3: stars[2]!, title: "Its Adding Up")
            }
        }else if(indexPath.row == 3){
            checkerInstance.TotalCalories(){ (totalCalories) in
                progressValues[indexPath.row] = Double(totalCalories)
                var stars = [emptyStar,emptyStar,emptyStar]
                if (totalCalories >= 1000.0 && totalCalories < 2500.0){
                    stars = [completedStar,emptyStar,emptyStar]
                    starsArray[indexPath.row] = [1,0,0]
                } else if(totalCalories >= 2500.0 && totalCalories < 5000.0){
                    stars = [completedStar,completedStar,emptyStar]
                    starsArray[indexPath.row] = [1,1,0]
                } else if(totalCalories >= 5000 ){
                    stars = [completedStar,completedStar,completedStar]
                    starsArray[indexPath.row] = [1,1,1]
                }
                cell.configure(trophy: UIImage(named: "achievements-icon")!, star1: stars[0]!, star2: stars[1]!, star3: stars[2]!, title: "Feel The Burn")
            }
        }else if(indexPath.row == 4){
            checkerInstance.BikeRideCount(){ (totalRides) in
                progressValues[indexPath.row] = Double(totalRides)
                var stars = [emptyStar,emptyStar,emptyStar]
                if (totalRides >= 1 && totalRides < 3){
                    stars = [completedStar,emptyStar,emptyStar]
                    starsArray[indexPath.row] = [1,0,0]
                } else if(totalRides >= 3 && totalRides < 7){
                    stars = [completedStar,completedStar,emptyStar]
                    starsArray[indexPath.row] = [1,1,0]
                } else if(totalRides >= 7 ){
                    stars = [completedStar,completedStar,completedStar]
                    starsArray[indexPath.row] = [1,1,1]
                }
                cell.configure(trophy: UIImage(named: "achievements-icon")!, star1: stars[0]!, star2: stars[1]!, star3: stars[2]!, title: "Biking Novice")
            }
        }
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 190)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            achievementTitle = "Sticking With It"
            achievementDesc = "Perform more exercises to reach higher levels with this achievement!"
            achievementGoal1 = "Complete 5 exercises"
            achievementGoal2 = "Complete 10 exercises"
            achievementGoal3 = "Complete 20 exercises"
            whichStar = indexPath.row
            progress = "You have completed \(Int(progressValues[indexPath.row])) workouts so far!"
                
            self.performSegue(withIdentifier: "showAchievement", sender: self)
        case 1:
            achievementTitle = "Marathon Runner"
            achievementDesc = "Accumulativly run the length of a marathon!"
            achievementGoal1 = "Completed 1 marathon"
            achievementGoal2 = "Completed 2 marathons"
            achievementGoal3 = "Completed 3 marathons"
            whichStar = indexPath.row
            progress = "You have completed \(round(progressValues[indexPath.row] * 100) / 100.0) marathons so far!"
                
            self.performSegue(withIdentifier: "showAchievement", sender: self)
        
        case 2:
            achievementTitle = "Its Adding Up"
            achievementDesc = "All exercises duration added up!"
            achievementGoal1 = "Exercised for 1 hours"
            achievementGoal2 = "Exercised for 2.5 hours"
            achievementGoal3 = "Exercised for 5 hours"
            whichStar = indexPath.row
            progress = "You have exercised for  \(round(progressValues[indexPath.row] * 10) / 10.0) hours so far!"
                
            self.performSegue(withIdentifier: "showAchievement", sender: self)
        case 3:
            achievementTitle = "Feel The Burn"
            achievementDesc = "Total calories burned from all exercises!"
            achievementGoal1 = "Burned 1000 calories"
            achievementGoal2 = "Burned 2500 calories"
            achievementGoal3 = "Burned 5000 calories"
            whichStar = indexPath.row
            progress = "You have burned a total of   \(round(progressValues[indexPath.row] * 10) / 10.0) calories so far!"
                
            self.performSegue(withIdentifier: "showAchievement", sender: self)
        case 4:
            achievementTitle = "Biking Novice"
            achievementDesc = "Perform bike ride workouts to reach the next levels!"
            achievementGoal1 = "Completed 1 bike ride"
            achievementGoal2 = "Completed 3 bike rides"
            achievementGoal3 = "Completed 7 bike ride"
            whichStar = indexPath.row
            progress = "You have performed   \(progressValues[indexPath.row]) bike rides!"
                
            self.performSegue(withIdentifier: "showAchievement", sender: self)
        default:
            self.performSegue(withIdentifier: "showAchievement", sender: self)
        }
    }
}
