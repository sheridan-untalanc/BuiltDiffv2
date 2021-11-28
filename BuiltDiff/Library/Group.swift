//
//  Group.swift
//  BuiltDiff
//
//  Created by Christian Untalan on 2021-10-09.
//

import Foundation

class Group {
    var GroupName : String = ""
    //var GroupImage : Data
    var GroupOwner : String = ""
    var GroupDescription : String = ""
    var Workouts : [Workout] = []
    var Exercises : [Exercise] =  []

    init(groupName: String, groupOwner: String, groupDescription: String, saveToDatabase: Bool) {
        GroupName = groupName
        GroupOwner = groupOwner
        GroupDescription = groupDescription
        if saveToDatabase == true{
            FirebaseAccessLayer.CreateGroupRemote(group: self)
        }
    }
    
    //Creating Local Group
    init(groupName: String, groupOwner: String, groupDescription: String, workouts: [Workout], exercises: [Exercise]) {
        GroupName = groupName
        GroupOwner = groupOwner
        GroupDescription = groupDescription
        Workouts = workouts
        Exercises = exercises
    }
    
    static func LoadAll(groupIds: [String]) async throws -> ([Group]){
        var groupFutures: [Group] = []
        for groupId in groupIds {
            let newGroup = try await FirebaseAccessLayer.GetGroup(groupId: groupId)
            groupFutures.append(newGroup)
        }
        return groupFutures
    }
}
