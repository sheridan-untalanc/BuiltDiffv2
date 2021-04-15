//
//  ViewController.swift
//  BuiltDiff
//
//  Created by Christian Untalan on 2021-03-17.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onLogin(_ sender: Any) {
        
        guard let email = emailInput.text, !email.isEmpty,
              let password = passwordInput.text, !password.isEmpty else {
            
            let alert = UIAlertController(title: "Error!", message: "One or more of the fields is empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if(error != nil){
                let errorMessage = error?.localizedDescription

                let alert = UIAlertController(title: "Error logging in!", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            if Auth.auth().currentUser != nil{
                let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let mainView  = mainStoryBoard.instantiateViewController(withIdentifier: "MainMenu") as! MainMenuViewController
                self.navigationController?.pushViewController(mainView, animated: true)
                self.present(mainView, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Error logging in!", message: "User could not be found", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
    
    }
    
}

