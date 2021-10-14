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
        
        if emailText.text == "" || passText.text == "" {
            let alert = UIAlertController(title: "Error!", message: "Please fill in all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        else {
            var loginStatus = FirebaseAccessLayer.LogIn(email: emailText.text!, password: passText.text!)
            if loginStatus.status == true {
                print("working")
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            }
            else{
                let alert = UIAlertController(title: "Error!", message: "\(loginStatus.1)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
    }
    
}
