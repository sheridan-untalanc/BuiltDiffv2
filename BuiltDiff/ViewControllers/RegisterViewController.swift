//
//  RegisterViewController.swift
//  BuiltDiff
//
//  Created by Christian Untalan on 2021-03-25.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var passwordConfirmInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onRegister(_ sender: Any) {
        if (passwordInput.text != passwordConfirmInput.text){
            let alert = UIAlertController(title: "Error!", message: "Passwords do not match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }

        guard let email = emailInput.text, !email.isEmpty,
              let username = usernameInput.text, !username.isEmpty,
              let password = passwordInput.text, !password.isEmpty else {

            let alert = UIAlertController(title: "Error!", message: "One or more of the fields is empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if(error != nil){
                let errorMessage = error!.localizedDescription
                print(errorMessage)

                let alert = UIAlertController(title: "Error creating a new account", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                self.present(alert, animated: true, completion: nil)
                return
            }
            var ref: DatabaseReference!
            ref = Database.database().reference().child("users")
            
            let userInfo = ["username": username,
                            "email": email]
            let childUpdates = ["\(authResult!.user.uid)" : userInfo]
            
            //ref.child("users/\(authResult!.user.uid)/email").setValue(email)
            
            ref.updateChildValues(childUpdates)
            
            let alert = UIAlertController(title: "Success!", message: "Your account has been created successfully.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.performSegue(withIdentifier: "createAccountSegue", sender: self)
            self.present(alert, animated: true, completion: nil)
            return
        }
    }

}
