//
//  RegisterViewController.swift
//  BuiltDiff
//
//  Created by Christian Untalan on 2021-03-25.
//

import UIKit

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

        FirebaseAccessLayer.Register(username: username, email: email, password: password)

        }

}
