//
//  FirebaseAccessLayer.swift
//  BuiltDiff
//
//  Created by Christian Untalan on 2021-09-25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import OSLog

class FirebaseAccessLayer{
    
    static let logger = Logger()
    private static let db = Firestore.firestore()
    
    static func GetCurrentUserId() -> String {
        return Auth.auth().currentUser!.uid
    }
    
    static func GetCurrentUsername(completion: @escaping (String) -> Void){
        let docRef = db.collection("users").document(GetCurrentUserId())
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()!
                let username = dataDescription["username"] as! String
                completion(username)
            } else {
                completion("Document does not exist")
            }
        
        }
    }
    
    static func IsLoggedIn() -> Bool{
        let currentUser = Auth.auth().currentUser
        if(currentUser != nil){
            return true
        }
        else {
            return false
        }
    }
    
    static func UploadGroupImage(imageData: Data){
        // Create a reference to the file you want to upload
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("images/profileImages/\(FirebaseAccessLayer.GetCurrentUserId())/groupImage.jpg")

        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = imageRef.putData(imageData, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            print("Uh-oh, an error occurred getting the metadata")
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          imageRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
                print("Uh-oh, an error occurred getting the download URL")
              return
            }
          }
        }
    }
    
    static func GetGroupImage(ownerUid: String, completion: @escaping (UIImage) -> Void){
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("images/profileImages/\(ownerUid)/groupImage.jpg")
        Task.init{
            let image = imageRef.getData(maxSize: 1 * 1024 * 1024, completion:{ data, error in
                if let error = error {
                    // Uh-oh, an error occurred!
                  } else {
                    let image = UIImage(data: data!)
                      completion(image!)
                  }
            })
        }
    }
    
    static func UpdateUserRemote(username: String) {
        db.collection("users").document(GetCurrentUserId()).setData([
            "username" : username
            ],  merge: true) { error in
                if let error = error {
                    print("Error updating User: \(error)")
                } else {
                    print("User sucessfully updated!")
                }
                
            }
        }
        
    static func CreateGroupRemote(groupName: String, groupOwner: String, groupDescription: String){
        let groupRef = db.collection("groups").addDocument(data: [
            "groupName" : groupName,
            "groupOwner" :  groupOwner,
            "groupDescription" :  groupDescription
        ]) { error in
            if let error = error {
                print("Error create Group: \(error)")
            } else {
                print("Group sucessfully created!")
            }
        }
            
        let userRef = db.collection("users").document(GetCurrentUserId())
        userRef.collection("assignedGroups").addDocument(data: ["groupId": groupRef.documentID])
        userRef.setData(["ownedGroup" : groupRef.documentID], merge: true)
    }

    static func UpdateGroupLocal(groupId: String) async throws -> (groupName: String, groupOwner: String, groupDescription: String){
        let groupRef = db.collection("groups").document(groupId)
            
        let snapshot = try await groupRef.getDocument()
        let groupDetails = snapshot.data()!
        let groupName = groupDetails["groupName"] as! String
        let groupOwner = groupDetails["groupOwner"] as! String
        let groupDescription = groupDetails["groupDescription"] as! String
        return (groupName, groupOwner, groupDescription)
    }
    
    static func UpdateUserLocal(uid: String) async throws -> (username: String, assignedGroups: [String: String], ownedGroup: String?){
        let userRef = db.collection("users").document(GetCurrentUserId())
        let assignedGroupsRef = userRef.collection("assignedGroups")
        
        let userSnapshot = try await userRef.getDocument()
        let userDetails = userSnapshot.data()!
        let username = userDetails["username"] as! String
        let ownedGroup = userDetails["ownedGroup"] as? String
        let assignedGroupsSnapshot = try await assignedGroupsRef.getDocuments()
        var assignedGroups : [String: String] = [:]
        for document in assignedGroupsSnapshot.documents{
            assignedGroups[document.documentID] = document["groupId"] as? String
        }
        
        return (username, assignedGroups, ownedGroup)
    }
}
