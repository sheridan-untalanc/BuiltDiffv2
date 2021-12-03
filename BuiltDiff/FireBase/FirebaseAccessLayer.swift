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
    
    static func GetUsername(userId: String) async throws -> (String){
        let docRef = db.collection("users").document(userId)
        let docData = try await docRef.getDocument().data()!
        return docData["username"] as! String
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
    
    // IMAGES
    
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
    
    //
    
    // USERS
    
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
    
    static func GetUser() async throws -> (Profile){
        let userRef = db.collection("users").document(GetCurrentUserId())
        let assignedGroupsRef = userRef.collection("assignedGroups")
        
        let userSnapshot = try await userRef.getDocument()
        let userDetails = userSnapshot.data()!
        let username = userDetails["username"] as! String
        let ownedGroup = userDetails["ownedGroup"] as? String
        let assignedGroupsSnapshot = try await assignedGroupsRef.getDocuments()
        var assignedGroups : [String] = []
        for document in assignedGroupsSnapshot.documents{
            assignedGroups.append(document["groupId"] as! String)
        }
        
        return Profile(username: username, groupList: assignedGroups, ownedGroup: ownedGroup)
    }
    
    //
    
    // GROUPS
        
    static func CreateGroupRemote(group: Group){
        let groupRef = db.collection("groups").addDocument(data: [
            "groupName" : group.GroupName,
            "groupOwner" :  group.GroupOwner,
            "groupDescription" :  group.GroupDescription
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

    static func GetGroup(groupId: String) async throws -> (Group){
        let groupRef = db.collection("groups").document(groupId)
            
        let snapshot = try await groupRef.getDocument()
        let groupDetails = snapshot.data()!
        let groupName = groupDetails["groupName"] as! String
        let groupOwner = groupDetails["groupOwner"] as! String
        let groupDescription = groupDetails["groupDescription"] as! String
        
        return try await Group(
            groupId: groupId,
            groupName: groupName,
            groupOwner: groupOwner,
            groupDescription: groupDescription,
            workouts: GetAllGroupWorkouts(groupId: groupId),
            exercises: GetExercises(groupId: groupId)
        )
    }
    
    //
    
    // WORKOUTS
    
    static func GetUserWorkout(workoutId: String) async throws -> (String){
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
    
    static func GetAllGroupWorkouts(groupId: String) async throws -> ([Workout]){
        var workoutFutures: [Workout] = []
        let workoutSnapshot = try await db.collection("groups").document(groupId).collection("workouts").getDocuments()
        let workoutDetails = workoutSnapshot.documents
        for workout in workoutDetails{
            let workoutData = workout.data()
            try await workoutFutures.append(Workout(
                name: workoutData["workoutName"] as! String,
                workoutTasks: GetGroupsWorkoutTasks(workoutId: workout.documentID, groupId: groupId)
            ))
        }
        
        return workoutFutures
    }
    
    static func GetAllUserCompletedWorkouts() async throws -> ([(workoutId: String, workoutName: String, dateCompleted: String)]){
        var workoutFutures: [(workoutId: String, workoutName: String, dateCompleted: String)] = []
        let workoutSnapshot = try await db.collection("users").document(GetCurrentUserId()).collection("completedWorkouts").getDocuments()
        let workoutDetails = workoutSnapshot.documents
        for workout in workoutDetails{
            let workoutData = workout.data()
            workoutFutures.append((
                workoutId: workout.documentID,
                workoutName: workoutData["workoutName"] as! String,
                dateCompleted: workoutData["dateCompleted"] as! String
            ))
        }
        
        return workoutFutures
    }
    
    static func PushUserWorkout(workout: Workout){
        let workoutRef = db.collection("users").document(GetCurrentUserId()).collection("workouts").addDocument(data: ["workoutName": workout.Name])
        FirebaseAccessLayer.PushUserWorkoutTasks(workoutId: workoutRef.documentID, workoutTasks: workout.WorkoutTasks)
    }
    
    static func PushGroupWorkout(workout: Workout, groupId: String){
        let workoutRef = db.collection("groups").document(groupId).collection("workouts").addDocument(data: ["workoutName": workout.Name])
        FirebaseAccessLayer.PushGroupWorkoutTasks(workoutId: workoutRef.documentID, groupId: groupId, workoutTasks: workout.WorkoutTasks)
    }
    
    static func PushAllGroupWorkouts(groupId: String, workouts: [Workout]){
        let workoutsRef = db.collection("groups").document(groupId).collection("workouts")
        
        for workout in workouts{
            workoutsRef.addDocument(data: [
                "workoutName": workout.Name
            ]){ error in
                if let error = error {
                    print("Error create Workout : \(error)")
                } else {
                    print("Workout sucessfully created!")
                }
            }
        }
    }
    
    static func PushCompletedWorkout(workout: Workout){
        let date = Date()
        let workoutRef = db.collection("users").document(GetCurrentUserId()).collection("completedWorkouts").addDocument(data: [
            "workoutName": workout.Name,
            "dateCompleted": date.formatted()
        ])
        FirebaseAccessLayer.PushUserCompletedWorkoutTasks(workoutId: workoutRef.documentID, workoutTasks: workout.WorkoutTasks)
    }
    static func JoinGroup(groupId: String) async throws -> Int{
        let userRef = db.collection("users").document(GetCurrentUserId()).collection("assignedGroups")
        let usersGroups = try await userRef.whereField("groupId", isEqualTo: groupId).getDocuments().documents
        if ((usersGroups.first?.exists) != nil){
            return -1
        }
        else{
            let groupRef = try await db.collection("groups").document(groupId).getDocument()
            if groupRef.exists{
                userRef.addDocument(data: ["groupId": groupId])
                return 0
            }
            else{
                return -2
            }
        }
    }
    
    //
    
    // WORKOUT TASKS
    
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
        let workoutTaskRef = db.collection("groups").document(groupId).collection("workouts").document(workoutId).collection("tasks")
        
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
    
    static func PushUserWorkoutTasks(workoutId: String, workoutTasks: [WorkoutTask]){
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
                    
    static func PushGroupWorkoutTasks(workoutId: String, groupId: String ,workoutTasks: [WorkoutTask]){
        let workoutTasksRef = db.collection("groups").document(groupId).collection("workouts").document(workoutId).collection("tasks")
        
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
    
    static func PushUserCompletedWorkoutTasks(workoutId: String, workoutTasks: [WorkoutTask]){
        let workoutTasksRef = db.collection("users").document(GetCurrentUserId()).collection("completedWorkouts").document(workoutId).collection("tasks")
        
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
    
    //
        
    // EXERCISES
    
    static func PushExercise(groupId: String, exercise: Exercise){
        db.collection("groups").document(groupId).collection("exercises").addDocument(data: [
            "originalUser": exercise.OriginalUser,
            "date": exercise.Date,
            "type": exercise.ExerciseType,
            "distance": exercise.Distance,
            "duration": exercise.Duration,
            "calories": exercise.Calories,
            "imageName": exercise.ImageName
        ]){ error in
            if let error = error {
                print("Error pushing execrise: \(error)")
            } else {
                print("Exercise sucessfully pushed to \(groupId)!")
            }
        }
    }
    
    static func GetExercises(groupId: String) async throws -> ([Exercise]){
        var exerciseFutures: [Exercise] = []
        let exerciseRef = db.collection("groups").document(groupId).collection("exercises")
        
        let exerciseSnapshot = try await exerciseRef.getDocuments()
        let exerciseDetails = exerciseSnapshot.documents
        for exercise in exerciseDetails{
            let exerciseData = exercise.data()
            exerciseFutures.append(Exercise(
                originalUser: exerciseData["originalUser"] as! String,
                date: exerciseData["date"] as! String,
                exerciseType: exerciseData["type"] as! String,
                distance: exerciseData["distance"] as! String,
                duration: exerciseData["duration"] as! String,
                calories: exerciseData["calories"] as! String,
                imageName: exerciseData["imageName"] as! String
            ))
        }
        
        return exerciseFutures
    }
    
    //
        
    // CHALLENGES
    
    static func GetChallenge(groupId: String) async throws -> (Challenge){
        let groupRef = db.collection("groups").document(groupId)
        let challengeData = try await groupRef.getDocument().data()!
        let challengeDetails = challengeData["challenge"] as? [String : Any] ?? [:]
        return Challenge(
            startDate: challengeDetails["startDate"] as? String ?? "N/A",
            endDate: challengeDetails["endDate"] as? String ?? "N/A",
            exerciseType: challengeDetails["exerciseType"] as? String ?? "N/A",
            goal: challengeDetails["goal"] as? String ?? "N/A",
            metric: challengeDetails["metric"] as? String ?? "N/A",
            points: challengeDetails["points"] as? Int ?? 0
        )
    }
    
    static func PushChallenge(groupId: String, challenge: Challenge) {
        db.collection("groups").document(groupId).setData(["challenge": [
            "startDate": challenge.StartDate,
            "endDate": challenge.EndDate,
            "exerciseType": challenge.ExerciseType,
            "goal": challenge.Goal,
            "metric": challenge.Metric,
            "points": challenge.Points
        ]], merge: true){ error in
            if let error = error {
                print("Error pushing challenge: \(error)")
            } else {
                print("Challenge sucessfully pushed to \(groupId)!")
            }
        }
    }

}
