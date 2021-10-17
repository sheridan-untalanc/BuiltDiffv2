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
    
    func MarathonRunner(completion: @escaping (Double) -> Void){
        
        var MarathonCompleted = 0.0
        var totalDistance = 0.0
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .running)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
                                              ascending: true)
        
        let query = HKSampleQuery(
          sampleType: .workoutType(),
          predicate: workoutPredicate,
          limit: 1000,
          sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            DispatchQueue.main.async {
              guard
                let samples = samples as? [HKWorkout],
                error == nil
                else {
                  return
              }
                for i in 0..<samples.count{
                    let distance = Double((samples[i].totalDistance!.doubleValue(for: HKUnit.meter()))/1000)
                    totalDistance = totalDistance + distance
                }
                MarathonCompleted = totalDistance/42.195
                completion(MarathonCompleted)
            }
          }

        HKHealthStore().execute(query)
        
    }
    
    func ExercisesCompleted(completion: @escaping (Int) -> Void){
            var completed = 0
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
                                                  ascending: true)

            let query = HKSampleQuery(
              sampleType: .workoutType(),
              predicate: nil,
              limit: 50,
              sortDescriptors: [sortDescriptor]) { (query, samples, error) in
                  DispatchQueue.main.async {
                  guard
                    let samples = samples as? [HKWorkout],
                    error == nil
                    else {
                      return
                  }
                completed = samples.count
                    completion(completed)
                }
              }
            HKHealthStore().execute(query)
        
    }
    func TotalDuration(completion: @escaping (Double) -> Void){
        
        var totalDuration = 0.0
        var duration = 0.0
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
                for i in 0..<samples.count{
                    duration = Double(samples[i].duration)
                    totalDuration = totalDuration + duration
                }
                totalDuration = totalDuration/3600
                completion(totalDuration)
            }
          }

        HKHealthStore().execute(query)
        
    }
    func TotalCalories(completion: @escaping (Double) -> Void){
        
        var totalCalories = 0.0
        var calories = 0.0
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
                for i in 0..<samples.count{
                    calories = Double(samples[i].totalEnergyBurned!.doubleValue(for: HKUnit.largeCalorie()))
                    totalCalories = totalCalories + calories
                }
                completion(totalCalories)
            }
          }

        HKHealthStore().execute(query)
        
    }
    
    func BikeRideCount(completion: @escaping (Int) -> Void){
        
        var totalRides = 0
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .cycling)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
                                              ascending: true)
        
        let query = HKSampleQuery(
          sampleType: .workoutType(),
          predicate: workoutPredicate,
          limit: 1000,
          sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            DispatchQueue.main.async {
              guard
                let samples = samples as? [HKWorkout],
                error == nil
                else {
                  return
              }
                totalRides = samples.count
                completion(totalRides)
            }
          }

        HKHealthStore().execute(query)
        
    }
    
}
