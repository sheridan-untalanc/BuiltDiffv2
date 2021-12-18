//
//  Group.swift
//  BuiltDiff
//
//  Created by Christian Untalan on 2021-10-09.
//

import Foundation

class Group {
    var GroupId : String = ""
    var GroupName : String = ""
    var GroupOwner : String = ""
    var GroupDescription : String = ""
    var Workouts : [Workout] = []
    var Exercises : [Exercise] =  []
    var JoinedUsers: [String: Int] = [:]

    init(groupName: String, groupOwner: String, groupDescription: String, saveToDatabase: Bool) {
        GroupName = groupName
        GroupOwner = groupOwner
        GroupDescription = groupDescription
        if saveToDatabase == true{
            FirebaseAccessLayer.CreateGroupRemote(group: self)
        }
    }
    
    init(groupId: String, groupName: String, groupOwner: String, groupDescription: String, workouts: [Workout], exercises: [Exercise], joinedUsers: [String: Int]) {
        GroupId = groupId
        GroupName = groupName
        GroupOwner = groupOwner
        GroupDescription = groupDescription
        Workouts = workouts
        Exercises = exercises
        JoinedUsers = joinedUsers
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
