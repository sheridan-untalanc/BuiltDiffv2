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
    
    static func LoadAllWorkouts() async throws -> ([Workout]){
        var futureWorkouts: [Workout] = []
        let listOfWorkouts = try await FirebaseAccessLayer.GetAllWorkouts()
        for workout in listOfWorkouts{
            try await futureWorkouts.append(
                Workout(name: workout.workoutName, workoutTasks: WorkoutTask.LoadTasks(workoutId: workout.workoutId), saveToDatabase: false)
            )
        }
        
        return futureWorkouts
    }
}
