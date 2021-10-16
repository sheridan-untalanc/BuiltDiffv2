//
//  LoginViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-02.
//

import UIKit
import FirebaseAuth

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
            Auth.auth().signIn(withEmail: emailText.text!, password: passText.text!) { (result, error) in
                if(error != nil){
                    let errorMessage = error!.localizedDescription
                    let alert = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                if Auth.auth().currentUser != nil{
                    print("User is found!")
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                    return
                }
                else{
                    let errorMessage = "User could not be found."
                    let alert = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }
            

        }
    }
    
}
