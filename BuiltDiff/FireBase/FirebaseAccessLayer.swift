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
    
    static func GetUsersWorkoutTasks(workoutId: String) async throws -> ([WorkoutTask]){
        var workoutTasksFutures: [WorkoutTask] = []
        let workoutTaskRef = db.collection("users").document(GetCurrentUserId()).collection("workouts").document(workoutId).collection("tasks")
        
        let workoutTaskSnapshot = try await workoutTaskRef.getDocuments()
        let workoutTaskDetails = workoutTaskSnapshot.documents
        for workoutTask in workoutTaskDetails{
            let workoutData = workoutTask.data()
            workoutTasksFutures.append(WorkoutTask(
                name: workoutData["taskName"] as! String,
                reps: workoutData["reps"] as! Int,
                sets: workoutData["sets"] as! Int,
                description: workoutData["description"] as! String
            ))
        }
        
        return workoutTasksFutures
    }
    
    static func GetGroupsWorkoutTasks(workoutId: String, groupId: String) async throws -> ([WorkoutTask]){
        var workoutTasksFutures: [WorkoutTask] = []
        let workoutTaskRef = db.collection("groups").document(GetCurrentUserId()).collection("workouts").document(workoutId).collection("tasks")
        
        let workoutTaskSnapshot = try await workoutTaskRef.getDocuments()
        let workoutTaskDetails = workoutTaskSnapshot.documents
        for workoutTask in workoutTaskDetails{
            let workoutData = workoutTask.data()
            workoutTasksFutures.append(WorkoutTask(
                name: workoutData["taskName"] as! String,
                reps: workoutData["reps"] as! Int,
                sets: workoutData["sets"] as! Int,
                description: workoutData["description"] as! String
            ))
        }
        
        return workoutTasksFutures
    }

    
    static func GetWorkout(workoutId: String) async throws -> (String){
        let workoutRef = db.collection("users").document(GetCurrentUserId()).collection("workouts").document(workoutId)
        let workoutDetails = try await workoutRef.getDocument().data()!
        return workoutDetails["workoutName"] as! String
    }
    
    static func GetAllUserWorkouts() async throws -> ([(workoutId: String, workoutName: String)]){
        var workoutFutures: [(workoutId: String, workoutName: String)] = []
        let workoutSnapshot = try await db.collection("users").document(GetCurrentUserId()).collection("workouts").getDocuments()
        let workoutDetails = workoutSnapshot.documents
        for workout in workoutDetails{
            let workoutData = workout.data()
            workoutFutures.append((workoutId: workout.documentID, workoutName: workoutData["workoutName"] as! String))
        }
        
        return workoutFutures
    }
    
    static func GetAllGroupWorkouts(groupId: String) async throws -> ([(workoutId: String, workoutName: String)]){
        var workoutFutures: [(workoutId: String, workoutName: String)] = []
        let workoutSnapshot = try await db.collection("groups").document(groupId).collection("workouts").getDocuments()
        let workoutDetails = workoutSnapshot.documents
        for workout in workoutDetails{
            let workoutData = workout.data()
            workoutFutures.append((workoutId: workout.documentID, workoutName: workoutData["workoutName"] as! String))
        }
        
        return workoutFutures
    }
    
    
    
    static func PushWorkoutTasks(workoutId: String, workoutTasks: [WorkoutTask]){
        let workoutTasksRef = db.collection("users").document(GetCurrentUserId()).collection("workouts").document(workoutId).collection("tasks")
        
        for workoutTask in workoutTasks{
            workoutTasksRef.addDocument(data: [
                "taskName": workoutTask.Name,
                "reps": workoutTask.Reps,
                "sets": workoutTask.Sets,
                "description": workoutTask.Description
            ]){ error in
                if let error = error {
                    print("Error create Workout Task: \(error)")
                } else {
                    print("Workout Task sucessfully created!")
                }
            }
        }
    }
    
    static func PushWorkout(workout: Workout){
        let workoutRef = db.collection("users").document(GetCurrentUserId()).collection("workouts").addDocument(data: ["workoutName": workout.Name])
        FirebaseAccessLayer.PushWorkoutTasks(workoutId: workoutRef.documentID, workoutTasks: workout.WorkoutTasks)
    }
}
