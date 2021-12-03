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
    
    func getValueForMetric(challengePassed: Challenge, completion: @escaping (Double) -> Void){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateFormattedStart: Date = dateFormatter.date(from: challengePassed.StartDate)!
        let dateFormattedEnd: Date = dateFormatter.date(from: challengePassed.EndDate)!
        var completedMetric:Double = 0.0
        var workoutPredicate = HKQuery.predicateForWorkouts(with: .cycling)
        
        if challengePassed.ExerciseType == "Running"{
            workoutPredicate = HKQuery.predicateForWorkouts(with: .running)
        } else if challengePassed.ExerciseType == "Walking"{
            workoutPredicate = HKQuery.predicateForWorkouts(with: .walking)
        } else if challengePassed.ExerciseType == "Swimming"{
            workoutPredicate = HKQuery.predicateForWorkouts(with: .swimming)
            
        }
            
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
                                              ascending: true)
        
        let query = HKSampleQuery(
          sampleType: .workoutType(),
          predicate: workoutPredicate,
          limit: 50,
          sortDescriptors: [sortDescriptor]) { (query, samples, error) in
              DispatchQueue.main.async {
              guard
                let samples = samples as? [HKWorkout],
                error == nil
                else {
                  return
              }
                  for i in 0..<samples.count{
                      let date = samples[i].startDate
                      print("monka\(date)")
                      let dateFormatter = DateFormatter()
                      dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                      let formattedDate = dateFormatter.string(from: date)
                      let fixedDate: Date = dateFormatter.date(from: formattedDate)!
                      if (fixedDate > dateFormattedStart && fixedDate < dateFormattedEnd){
                          print("Made it in")
                          if challengePassed.Metric == "Calories"{
                              completedMetric += Double(samples[i].totalEnergyBurned!.doubleValue(for: HKUnit.largeCalorie()))
                          } else if challengePassed.Metric == "Distance (Km)"{
                              if samples[i].totalDistance == nil {
                                  completedMetric += 0.0
                              } else {
                                  completedMetric += Double((samples[i].totalDistance!.doubleValue(for: HKUnit.meter()))/1000)
                              }
                          } else if challengePassed.Metric == "Duration (min)"{
                              completedMetric += Double(samples[i].duration/60)
                          }
                      }
                  }
                  completion(completedMetric)
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
    
    func ExerciseList(completion: @escaping (Array<Array<String>>) -> Void){
        var completed = [[String]]()
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
                                                ascending: true)
        
        let query = HKSampleQuery(
          sampleType: .workoutType(),
          predicate: nil,
          limit: 20,
          sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            DispatchQueue.main.async {
              guard
                let samples = samples as? [HKWorkout],
                error == nil
                else {
                  return
              }
                for i in 0..<samples.count{
                    let calories = Double((samples[i].totalEnergyBurned!.doubleValue(for: HKUnit.largeCalorie())))

                    var exerciseType = ""
                    var imageType = ""
                    switch samples[i].workoutActivityType.rawValue{
                    case 46:
                        exerciseType = "Swimming"
                        imageType = "swimmingIcon"
                    case 13:
                        exerciseType = "Cycling"
                        imageType = "bikingIcon"
                    case 52:
                        exerciseType = "Walking"
                        imageType = "walkingIcon"
                    default:
                        exerciseType = "Generic Workout"
                        imageType = "runningIcon"
                    }

                    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
                        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
                    }
                    let (h,m,s) = secondsToHoursMinutesSeconds(seconds: Int(samples[i].duration))
                        
                    let date = samples[i].startDate
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/YY"
                    let formattedDate = dateFormatter.string(from: date)
                        
                    var distance = 0.0
                    
                    if samples[i].totalDistance == nil {
                        distance = 0.0
                    } else {
                        distance = Double((samples[i].totalDistance!.doubleValue(for: HKUnit.meter()))/1000)
                    }
                    
                    let workout = [exerciseType, "\(h)h \(m)m \(s)s", "\(String(calories.rounded(.awayFromZero))) Cal", formattedDate, imageType, "\(distance.rounded(.awayFromZero)) Km"]
                    completed.append(workout)
                }
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



