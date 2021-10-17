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
    
    init(userName: String) {
        UserName = userName
    }
    init(){
        FirebaseAccessLayer.UpdateUserLocal(uid: FirebaseAccessLayer.GetCurrentUserId(), completion: { (username, listOfGroups) in
            DispatchQueue.main.async {
                self.UserName = username
                self.GroupList = listOfGroups
            }
        })
    }
    
    func UpdateRemote() {
        FirebaseAccessLayer.UpdateUserRemote(username: UserName)
    }
    
    func UpdateLocal(){
        FirebaseAccessLayer.UpdateUserLocal(uid: FirebaseAccessLayer.GetCurrentUserId(), completion: { (username, listOfGroups) in
            self.UserName = username
            self.GroupList = listOfGroups
            
        })
    }
    
}
