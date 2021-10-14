//
//  LoginViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-02.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func loginTapped(_ sender: Any) {
        //for christian
        
        //var loginStatus = FirebaseAccessLayer.LogIn(email: <#T##String#>, password: <#T##String#>)
        
        self.performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
}
