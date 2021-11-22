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
    
    static func LoadTasks(workoutId: String) async throws -> ([WorkoutTask]){
        return try await FirebaseAccessLayer.GetWorkoutTasks(workoutId: workoutId)
    }
}
