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
                let dataDescription = document.data()?.description ?? "nil"
                completion(dataDescription)
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
    
    static func UploadImage(imageData: Data, fileName: String){
        // Create a reference to the file you want to upload
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("images/\(fileName).jpg")

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
            
        db.collection("users").document(GetCurrentUserId()).collection("assignedGroups").addDocument(data: ["groupId": groupRef.documentID])
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
    
    static func UpdateUserLocal(uid: String) async throws -> (username: String, assignedGroups: [String: String]){
        let userRef = db.collection("users").document(GetCurrentUserId())
        
        let snapshot = try await userRef.getDocument()
        let userDetails = snapshot.data()!
        let username = userDetails["username"] as! String
        let assignedGroups = userDetails["assignedGroups"] as? [String: String] ?? [:]
        return (username, assignedGroups)
    }
}
