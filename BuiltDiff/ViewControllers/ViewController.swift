//
//  ViewController.swift
//  BuiltDiff
//
//  Created by Christian Untalan on 2021-03-17.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onLogin(_ sender: Any) {
        guard let email = usernameInput.text, !email.isEmpty,
              let password = passwordInput.text, !password.isEmpty else {
            print("Missing field data")
            return
        }
        
        
    
    }
    
}

