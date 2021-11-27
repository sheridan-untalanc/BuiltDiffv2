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
    
    //Create workout under user
    init(name: String, workoutTasks: [WorkoutTask], saveToDatabase: Bool){
        Name = name
        WorkoutTasks = workoutTasks
        if saveToDatabase{
            FirebaseAccessLayer.PushUserWorkout(workout: self)
        }
    }
    
    //Create workout under group
    init(groupId: String, name: String, workoutTasks: [WorkoutTask], saveToDatabase: Bool){
        Name = name
        WorkoutTasks = workoutTasks
        if saveToDatabase{
            FirebaseAccessLayer.PushGroupWorkout(workout: self, groupId: groupId)
        }
    }
    
    init(name: String, workoutTasks: [WorkoutTask]){
        Name = name
        WorkoutTasks = workoutTasks
    }
    
//    static func LoadUserWorkout(workoutId: String) async throws -> (Workout){
//        return try await Workout(name: FirebaseAccessLayer.GetUserWorkout(workoutId: workoutId), workoutTasks: WorkoutTask.LoadUserWorkoutTasks(workoutId: workoutId))
//    }
//
//    static func LoadGroupWorkout(workoutId: String, groupId: String) async throws -> (Workout){
//        return try await Workout(name: FirebaseAccessLayer.GetGroupWorkout(workoutId: workoutId, groupId: group), workoutTasks: WorkoutTask.LoadGroupWorkoutTasks(workoutId: workoutId, groupId: groupId))
//    }
    
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
            try await futureWorkouts.append(workout)
        }
        
        return futureWorkouts
    }
}
