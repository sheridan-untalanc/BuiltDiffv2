//
//  Workout.swift
//  BuiltDiff
//
//  Created by Christian Untalan on 2021-11-20.
//

import Foundation

class Workout {
    var Name: String
    var WorkoutTasks: [WorkoutTask]
    
    init(name: String, workoutTasks: [WorkoutTask], saveToDatabase: Bool){
        Name = name
        WorkoutTasks = workoutTasks
        if saveToDatabase {
            FirebaseAccessLayer.PushWorkout(workout: self)
        }
    }
    
    static func LoadWorkout(workoutId: String) async throws -> (Workout){
        return try await Workout(name: FirebaseAccessLayer.GetWorkout(workoutId: workoutId), workoutTasks: WorkoutTask.LoadTasks(workoutId: workoutId), saveToDatabase: false)
    }
}
