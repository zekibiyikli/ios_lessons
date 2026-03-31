//
//  ViewController.swift
//  InstagramClone
//
//  Created by Zeki Mac on 30.03.2026.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func btnSignin(_ sender: Any) {
        let emailText = emailField.text ?? ""
        let passwordText = passwordField.text ?? ""

        if emailText.isEmpty==false && passwordText.isEmpty == false {
            Auth.auth().signIn(withEmail: emailText, password: passwordText){ authResult, error in
                if error != nil {
                    self.makeAlert(title: "Error", description:  error?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            makeAlert(title: "Error", description: "Username or password is incorrect")
        }
            
    }
    @IBAction func btnSignup(_ sender: Any) {
        let emailText = emailField.text ?? ""
        let passwordText = passwordField.text ?? ""
        
        if emailText.isEmpty==false && passwordText.isEmpty == false {
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { authResult, error in
                if error != nil {
                    self.makeAlert(title: "Error", description:  error?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            makeAlert(title: "Error", description: "Username or password is incorrect")
        }
    }
    
    func makeAlert(title:String,description:String){
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}

