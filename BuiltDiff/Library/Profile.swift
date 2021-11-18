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
    var GroupList : [String: String] = [:]
    
    var OwnedGroup : String?
    
    init(userName: String) {
        UserName = userName
    }
    
    init(username: String, groupList: [String: String], ownedGroup: String?){
            UserName = username
            GroupList = groupList
            OwnedGroup = ownedGroup
    }

    static func GetProfile() async throws -> Profile{
        var futureProfile: Profile
        let profileData = try await FirebaseAccessLayer.UpdateUserLocal(uid: FirebaseAccessLayer.GetCurrentUserId())
        futureProfile = Profile(username: profileData.username, groupList: profileData.assignedGroups, ownedGroup: profileData.ownedGroup)
        return futureProfile
    }
    
}
