//
//  AchievementChecker.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-10-14.
//

import Foundation
import UIKit
import HealthKit


class AchievementChecker: NSObject {
    
    let healthKitStore:HKHealthStore = HKHealthStore()
    
    func MarathonRunner() -> Double{
        
        var Completion = 0.0
        var totalDistance = 0.0
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .cycling)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
                                              ascending: true)
        
        let query = HKSampleQuery(
          sampleType: .workoutType(),
          predicate: nil,
          limit: 1000,
          sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            DispatchQueue.main.async {
              guard
                let samples = samples as? [HKWorkout],
                error == nil
                else {
                  return
              }
                print("meme3")
                for i in 0..<samples.count{
                    let distance = Double((samples[i].totalDistance!.doubleValue(for: HKUnit.meter()))/1000)
                    print("\(String((distance).rounded(.awayFromZero))) km")
                    totalDistance = totalDistance + distance
                }
                Completion = totalDistance/42.195
                print("meme2")
            }
          }

        HKHealthStore().execute(query)
        
        print("meme")
        return Completion
    }
}
