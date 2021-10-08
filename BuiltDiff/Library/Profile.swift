//
//  Profile.swift
//  BuiltDiff
//
//  Created by Christian Untalan on 2021-10-08.
//

import Foundation

struct Profile {
    var UserName : String
    //var ProfileImage : Data

    init(userName: String) {
        UserName = userName
    }
    
    func UpdateRemote() {
        FirebaseAccessLayer.UpdateUser(username: UserName)
    }
    
}
