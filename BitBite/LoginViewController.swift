//
//  ViewController.swift
//  BitBite
//
//  Created by Bobby Chen on 3/10/17.
//  Copyright © 2017 BMStudios. All rights reserved.
//

import UIKit
import FirebaseAuth
import Validator

class LoginViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    @IBAction func loginButton(_ sender: Any) {
        errorLabel.text = ""
        
        let emailRule = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: NSError())
        let minLengthRule = ValidationRuleLength(min: 1, error: NSError())
        
        if (emailTextField.text?.validate(rule: minLengthRule) != .valid && passwordTextField.text?.validate(rule: minLengthRule) != .valid) {
            return
        } else if (emailTextField.text?.validate(rule: minLengthRule) != .valid) {
            errorLabel.text = "Oops! Please enter email"
        } else if (emailTextField.text?.validate(rule: emailRule) != .valid) {
            errorLabel.text = "Oops! Your email is invalid"
        } else if (passwordTextField.text?.validate(rule: minLengthRule) != .valid) {
            errorLabel.text = "Oops! Please enter password"
        } else {
            errorLabel.text = "Loggin in..."
            FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error == nil {
                    //User logged in
                    print(FIRAuth.auth()?.currentUser?.uid)
                    self.performSegue(withIdentifier: "login", sender: self)
                } else {
                    self.errorLabel.text = "Failed to Log in"
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            print("AuthListener Added")
            print(auth.currentUser?.uid)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        errorLabel.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if FIRAuth.auth()?.currentUser != nil { performSegue(withIdentifier: "login", sender: self) }
    }

}

