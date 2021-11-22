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

    init(groupName: String, groupOwner: String, groupDescription: String, saveToDatabase: Bool) {
        GroupName = groupName
        GroupOwner = groupOwner
        GroupDescription = groupDescription
        if saveToDatabase == true{
            FirebaseAccessLayer.CreateGroupRemote(groupName: groupName, groupOwner: groupOwner, groupDescription: groupDescription)
        }
    }
    
    static func LoadAll(groupIds: [String]) async throws -> ([Group]){
        var groupFutures: [Group] = []
        for groupId in groupIds {
            let groupData = try await FirebaseAccessLayer.UpdateGroupLocal(groupId: groupId)
            groupFutures.append(Group(groupName: groupData.groupName,
            groupOwner: groupData.groupOwner,
                                      groupDescription: groupData.groupDescription, saveToDatabase: false))
        }
        return groupFutures
    }
//    init(groupId: String){
//        Task.init {
//            print("Started loading group")
//            let group = try await FirebaseAccessLayer.UpdateGroupLocal(groupId: groupId)
//            GroupName = group.groupName
//            print("Finished loading group\(GroupName)")
//            GroupOwner = group.groupOwner
//        }
//    }
    
//    func UpdateRemote() {
//        FirebaseAccessLayer.UpdateGroupRemote(groupName: GroupName, groupOwner: GroupOwner)
//    }
    
//    func UpdateLocal() {
//        FirebaseAccessLayer.UpdateGroupLocal(groupId: <#T##String#>, completion: <#T##(NSEnumerator) -> Void#>)
//    }
}
