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

class FirebaseAccessLayer{
    
    static func GetCurrentUser() -> String {
        return Auth.auth().currentUser!.uid
    }
    
    static func Register(username: String, email: String, password: String){
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if(error != nil){
                    let errorMessage = error?.localizedDescription
                    print(errorMessage!)

                    //let alert = UIAlertController(title: "Error creating a new account", message: errorMessage, preferredStyle: .alert)
                    //alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                    //self.present(alert, animated: true, completion: nil)
                    return
                }
                
                var ref: DatabaseReference!
                ref = Database.database().reference().child("users")
                
                let userInfo = ["username": username,
                                "email": email]
                let childUpdates = ["\(authResult!.user.uid)" : userInfo]
                
                //ref.child("users/\(authResult!.user.uid)/email").setValue(email)
                
                ref.updateChildValues(childUpdates)
                
                //let alert = UIAlertController(title: "Success!", message: "Your account has been created successfully.", preferredStyle: .alert)
                //alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                //self.present(alert, animated: true, completion: nil)
                return
        }
    }
    
    static func LogIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if(error != nil){
                let errorMessage = error?.localizedDescription
                print(errorMessage!)
                
                //let alert = UIAlertController(title: "Error logging in!", message: errorMessage, preferredStyle: .alert)
                //alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                //self.present(alert, animated: true, completion: nil)
                return
            }
            
            if Auth.auth().currentUser != nil{
                print("User is found!")
                
                //TODO: Update login navigation
                
                //let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                //let mainView  = mainStoryBoard.instantiateViewController(withIdentifier: "MainMenu") as! MainMenuViewController
                //self.navigationController?.pushViewController(mainView, animated: true)
                //self.present(mainView, animated: true, completion: nil)
                return
            }
            else{
                print("User could not be found")
                
                //let alert = UIAlertController(title: "Error logging in!", message: "User could not be found" preferredStyle: .alert)
                //alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                //self.present(alert, animated: true, completion: nil)
                return
            }
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
            var ref: DatabaseReference!
            ref = Database.database().reference().child("users")
            
            //TODO: update values as they are created
            let userInfo = ["username": username]
            
            let childUpdates = ["\(Auth.auth().currentUser!.uid)" : userInfo]
            
            ref.updateChildValues(childUpdates)
        }
        
    static func UpdateGroupRemote(groupName: String){
        var ref: DatabaseReference!
        ref = Database.database().reference().child("groups")
        
        //TODO: update values as they are created
        let userInfo = ["groupName": groupName]
        let childUpdates = ["\(Auth.auth().currentUser!.uid)" : userInfo]
        
        ref.updateChildValues(childUpdates)
    }
}
