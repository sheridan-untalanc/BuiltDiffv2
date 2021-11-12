//
//  FirebaseAccessLayer.swift
//  BuiltDiff
//
//  Created by Christian Untalan on 2021-09-25.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import OSLog

class FirebaseAccessLayer{
    
    static let logger = Logger()
    
    static func GetCurrentUserId() -> String {
        return Auth.auth().currentUser!.uid
    }
    
    static func GetCurrentUsername(completion: @escaping (String)-> Void){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users/\(GetCurrentUserId())/username").getData(completion:  { error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            return;
          }
            completion(snapshot.value as? String ?? "Unknown")
        });
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
    
    //Login Methods moved out of FAL due to needing await to handle auth.SignIn() async completion
    /*static func LogIn(email: String, password: String) -> (status: Bool, message: String) {
        var status = false
        var message = ""
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if(error != nil){
                message = error!.localizedDescription
                logger.error("\(message)")
                return
            }
            if Auth.auth().currentUser != nil{
                message = "User is found!"
                logger.debug("\(message)")
                status = true
                return
            }
            else{
                message = "User could not be found"
                logger.error("\(message)")
                return
            }
        }
        
        return (status, message)
    }
    
    static func Register(username: String, email: String, password: String) -> (status: Bool, message: String){
        var status = false
        var message = ""
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if(error != nil){
                message = error!.localizedDescription
                logger.error("\(message)")

                //let alert = UIAlertController(title: "Error creating a new account", message: errorMessage, preferredStyle: .alert)
                //alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                //self.present(alert, animated: true, completion: nil)
                return
            }
            status = true
            message = "Your account has been created successfully."
            
            var ref: DatabaseReference!
            ref = Database.database().reference().child("users")
            
            let userInfo = ["username": username,
                            "email": email]
            let childUpdates = ["\(authResult!.user.uid)" : userInfo]
            
            //ref.child("users/\(authResult!.user.uid)/email").setValue(email)
            
            ref.updateChildValues(childUpdates)
            return
        }
        
        return (status, message)
    }*/
    
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
            var ref: DatabaseReference!
            ref = Database.database().reference().child("users")
            
            //TODO: update values as they are created
            let userInfo = ["username": username]
            
            let childUpdates = ["\(Auth.auth().currentUser!.uid)" : userInfo]
            
            ref.updateChildValues(childUpdates)
        }
        
    static func CreateGroupRemote(groupName: String, groupOwner: String, groupDescription: String){
        var ref: DatabaseReference!
        ref = Database.database().reference().child("groups")
        guard let groupKey = ref.childByAutoId().key else{
            return
        }
        
        //TODO: update values as they are created
        let groupInfo = ["groupName": groupName, "groupOwner": groupOwner, "groupDescription": groupDescription]
        let childUpdates = ["\(groupKey)" : groupInfo]
        
        ref.updateChildValues(childUpdates)
        
        ref = Database.database().reference().child("users/\(groupOwner)/assignedGroups/")
        guard let assignedGroupKey = ref.childByAutoId().key else{
            return
        }
        let assignedGroupUpdates = ["\(assignedGroupKey)" : groupKey]
        ref.updateChildValues(assignedGroupUpdates)
    }
    
//    static func UpdateGroupLocal(groupId: String, completion: @escaping (NSEnumerator)-> Void){
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//        ref.child("groups/\(groupId)/").getData(completion:  { error, snapshot in
//          guard error == nil else {
//            print(error!.localizedDescription)
//            return;
//          }
//            completion(snapshot.children)
//        });
//    }
    static func UpdateGroupLocal(groupId: String) async throws -> (groupName: String, groupOwner: String, groupDescription: String){
            var ref: DatabaseReference!
            ref = Database.database().reference()
            let snapshot = try await ref.child("groups/\(groupId)/").getData();
            let groupDetails = snapshot.value as! [String: AnyObject]
            let groupName = groupDetails["groupName"] as! String
            let groupOwner = groupDetails["groupOwner"] as! String
            let groupDescription = groupDetails["groupDescription"] as! String
            return (groupName, groupOwner, groupDescription)
        }
    
    static func UpdateUserLocal(uid: String) async throws -> (username: String, assignedGroups: [String: String]){
            var ref: DatabaseReference!
            ref = Database.database().reference()
            let snapshot = try await ref.child("users/\(uid)/").getData();
            let userDetails = snapshot.value as! [String: AnyObject]
            let username = userDetails["username"] as! String
            let assignedGroups = userDetails["assignedGroups"] as? [String: String] ?? [:]
            return (username, assignedGroups)
        }
}
