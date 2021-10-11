//
//  ExerciseViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-02.
//

import UIKit
import HealthKit

let healthKitStore:HKHealthStore = HKHealthStore()

class ExerciseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authorizeHealthKitInApp()

        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (view.frame.size.width),
                                 height: (view.frame.size.height/3.5))
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
//        cell.contentView.backgroundColor = .blue
        cell.configure(label: "Exercise \(indexPath.row)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("User tapped on item \(indexPath.row)")
//        print(colories)
          let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
                                                ascending: true)
        
        let query = HKSampleQuery(
          sampleType: .workoutType(),
          predicate: nil,
          limit: 10,
          sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            DispatchQueue.main.async {
              guard
                let samples = samples as? [HKWorkout],
                error == nil
                else {
                  return
              }
                let sample = samples[3]
                
//                let distance = Double((sample.totalDistance!.doubleValue(for: HKUnit.meter())))
//                self.lblDistance.text = "\(String((distance/1000).rounded(.awayFromZero))) km"
                
                let calories = Double((sample.totalEnergyBurned!.doubleValue(for: HKUnit.largeCalorie())))
                
                var exerciseType = ""
                switch sample.workoutActivityType.rawValue{
                case 46:
                    exerciseType = "Swimming"
                case 13:
                    exerciseType = "Cycling"
                case 52:
                    exerciseType = "Walking"
                default:
                    exerciseType = "Generic Workout"
                }
                
                func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
                  return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
                }
                let (h,m,s) = secondsToHoursMinutesSeconds(seconds: Int(sample.duration))
                print(samples[2].duration)
              
            }
          }

        HKHealthStore().execute(query)
    }
}
