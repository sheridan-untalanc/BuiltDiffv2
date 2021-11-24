//
//  Profile.swift
//  BuiltDiff
//
//  Created by Christian Untalan on 2021-10-08.
//

import Foundation

class Profile {
    var UserName : String = "Unknown"
    //var ProfileImage : Data
    var GroupList : [String] = []
    
    var OwnedGroup : String?
    
    init(userName: String) {
        UserName = userName
    }
    
    init(username: String, groupList: [String], ownedGroup: String?){
            UserName = username
            GroupList = groupList
            OwnedGroup = ownedGroup
    }

    static func GetProfile() async throws -> Profile{
        return try await FirebaseAccessLayer.GetUser()
    }
    
}
