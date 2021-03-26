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
              let password = passwordInput.text, !password.isEmpty else {
            print("Missing field data")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if(error != nil){
                let errorMessage = error?.localizedDescription

                let alert = UIAlertController(title: "Error creating a new account", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            var ref: DatabaseReference!
            ref = Database.database().reference()
            
            ref.child("users/\(authResult!.user.uid)/email").setValue(email)
            
            let alert = UIAlertController(title: "Success!", message: "Your account has been created successfully.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
