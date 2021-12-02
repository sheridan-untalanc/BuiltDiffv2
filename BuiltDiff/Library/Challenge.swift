//
//  Challenge.swift
//  BuiltDiff
//
//  Created by Christian Untalan on 2021-11-30.
//

import Foundation

class Challenge{
    var StartDate: String
    var EndDate: String
    var ExerciseType: String
    var Goal: String
    var Metric: String
    var Points: Int
    
    init(startDate: String, endDate: String, exerciseType: String, goal: String, metric: String, points: Int){
        StartDate = startDate
        EndDate = endDate
        ExerciseType = exerciseType
        Goal = goal
        Metric = metric
        Points = points
    }
    
    static func LoadChallenge(groupId: String) async throws -> Challenge{
        return try await FirebaseAccessLayer.GetChallenge(groupId: groupId)
    }
}
