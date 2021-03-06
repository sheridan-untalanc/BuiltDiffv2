//
//  HomeViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-02.
//

import UIKit
import HealthKit

//BEWARE
var profile : Profile?

class HomeViewController: UIViewController {

    @IBOutlet weak var imageExercise1: UIImageView!
    @IBOutlet weak var imageExercise2: UIImageView!
    @IBOutlet weak var imageExercise3: UIImageView!
    @IBOutlet weak var imageExercise4: UIImageView!
    @IBOutlet weak var imageExercise5: UIImageView!
    @IBOutlet weak var homeTitle: UILabel!
    
    var workouts = [[String]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.authorizeHealthKitInApp()
        imageExercise1.layer.cornerRadius = 10
        imageExercise2.layer.cornerRadius = 10
        imageExercise3.layer.cornerRadius = 10
        imageExercise4.layer.cornerRadius = 10
        imageExercise5.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        FirebaseAccessLayer.GetCurrentUsername{ (username) in
            DispatchQueue.main.async {
                self.homeTitle.text = "Welcome back, \(username)"
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Task.init{
            profile = try await Profile.GetProfile()
        }
    }
    
    func authorizeHealthKitInApp()
    {
        let healthKitTypeToRead : Set<HKWorkoutType> = [
            HKWorkoutType.workoutType()

        ]
        let healthKitTypesToWrite : Set<HKSampleType> = [
            HKWorkoutType.workoutType()
        ]
        
        if !HKHealthStore.isHealthDataAvailable()
        {
            print("Error occured")
            return
        }
        
        healthKitStore.requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypeToRead)
        { (success, error) -> Void in
            print ("Read Write Authorization succeeded")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
