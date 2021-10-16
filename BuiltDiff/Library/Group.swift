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

    init(groupName: String) {
        GroupName = groupName
    }
    
    func UpdateRemote() {
        FirebaseAccessLayer.UpdateGroupRemote(groupName: GroupName)
    }
    
}
