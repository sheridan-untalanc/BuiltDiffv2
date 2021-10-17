//
//  Group.swift
//  BuiltDiff
//
//  Created by Christian Untalan on 2021-10-09.
//

import Foundation

struct Group {
    var GroupName : String
    //var GroupImage : Data
    var GroupOwner : String

    init(groupName: String, groupOwner: String) {
        GroupName = groupName
        GroupOwner = groupOwner
        FirebaseAccessLayer.CreateGroupRemote(groupName: groupName, groupOwner: groupOwner)
    }
    
//    func UpdateRemote() {
//        FirebaseAccessLayer.UpdateGroupRemote(groupName: GroupName, groupOwner: GroupOwner)
//    }
    
//    func UpdateLocal() {
//        FirebaseAccessLayer.UpdateGroupLocal(groupId: <#T##String#>, completion: <#T##(NSEnumerator) -> Void#>)
//    }
}
