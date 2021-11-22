//
//  WorkoutTask.swift
//  BuiltDiff
//
//  Created by Christian Untalan on 2021-11-20.
//

import Foundation

class WorkoutTask {
    var Name : String
    var Reps: Int
    var Sets: Int
    var Description : String
    
    init(name: String, reps: Int, sets: Int, description : String){
        Name = name
        Reps = reps
        Sets = sets
        Description = description
    }
    
    static func LoadUserTasks(workoutId: String) async throws -> ([WorkoutTask]){
        return try await FirebaseAccessLayer.GetUsersWorkoutTasks(workoutId: workoutId)
    }
    
    static func LoadGroupTasks(workoutId: String) async throws -> ([WorkoutTask]){
        return try await FirebaseAccessLayer.GetGroupsWorkoutTasks(workoutId: workoutId)
    }
}
