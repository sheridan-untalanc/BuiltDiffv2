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
        return try await Workout(name: FirebaseAccessLayer.GetWorkout(workoutId: workoutId), workoutTasks: WorkoutTask.LoadUserWorkoutTasks(workoutId: workoutId), saveToDatabase: false)
    }
    
    static func LoadGroupWorkout(workoutId: String, groupId: String) async throws -> (Workout){
        return try await Workout(name: FirebaseAccessLayer.GetWorkout(workoutId: workoutId), workoutTasks: WorkoutTask.LoadGroupWorkoutTasks(workoutId: workoutId, groupId: groupId), saveToDatabase: false)
    }
    
    static func LoadAllUsersWorkouts() async throws -> ([Workout]){
        var futureWorkouts: [Workout] = []
        let listOfWorkouts = try await FirebaseAccessLayer.GetAllUserWorkouts()
        for workout in listOfWorkouts{
            try await futureWorkouts.append(
                Workout(name: workout.workoutName, workoutTasks: WorkoutTask.LoadUserWorkoutTasks(workoutId: workout.workoutId), saveToDatabase: false)
            )
        }
        
        return futureWorkouts
    }
    
    static func LoadAllGroupsWorkouts(groupId: String) async throws -> ([Workout]){
        var futureWorkouts: [Workout] = []
        let listOfWorkouts = try await FirebaseAccessLayer.GetAllGroupWorkouts(groupId: groupId)
        for workout in listOfWorkouts{
            try await futureWorkouts.append(
                Workout(name: workout.workoutName, workoutTasks: WorkoutTask.LoadGroupWorkoutTasks(workoutId: workout.workoutId, groupId: groupId), saveToDatabase: false)
            )
        }
        
        return futureWorkouts
    }
}
