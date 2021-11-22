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
    
    static func LoadUserWorkout(workoutId: String) async throws -> (Workout){
        return try await Workout(name: FirebaseAccessLayer.GetWorkout(workoutId: workoutId), workoutTasks: WorkoutTask.LoadUserTasks(workoutId: workoutId), saveToDatabase: false)
    }
    
    static func LoadGroupWorkout(workoutId: String) async throws -> (Workout){
        return try await Workout(name: FirebaseAccessLayer.GetWorkout(workoutId: workoutId), workoutTasks: WorkoutTask.LoadGroupTasks(workoutId: workoutId), saveToDatabase: false)
    }
    
    static func LoadAllUsersWorkouts() async throws -> ([Workout]){
        var futureWorkouts: [Workout] = []
        let listOfWorkouts = try await FirebaseAccessLayer.GetAllUserWorkouts()
        for workout in listOfWorkouts{
            try await futureWorkouts.append(
                Workout(name: workout.workoutName, workoutTasks: WorkoutTask.LoadUserTasks(workoutId: workout.workoutId), saveToDatabase: false)
            )
        }
        
        return futureWorkouts
    }
    
    static func LoadAllGroupsWorkouts() async throws -> ([Workout]){
        var futureWorkouts: [Workout] = []
        let listOfWorkouts = try await FirebaseAccessLayer.GetAllGroupWorkouts()
        for workout in listOfWorkouts{
            try await futureWorkouts.append(
                Workout(name: workout.workoutName, workoutTasks: WorkoutTask.LoadGroupTasks(workoutId: workout.workoutId), saveToDatabase: false)
            )
        }
        
        return futureWorkouts
    }
}
