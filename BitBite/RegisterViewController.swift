//
//  RegisterViewController.swift
//  BitBite
//
//  Created by Michael Rojas on 3/10/17.
//  Copyright © 2017 BMStudios. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Validator

class RegisterViewController: UIViewController {
    
    var uid = String()
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBAction func registerButton(_ sender: Any) {
        errorLabel.text = ""
        let emailRule = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: NSError())
        let minLengthRule = ValidationRuleLength(min: 8, error: NSError())
        let equalityRule = ValidationRuleEquality<String>(dynamicTarget: { return self.passwordTextField.text ?? "" }, error: NSError())
        if (emailTextField.text?.validate(rule: emailRule) != .valid) {
            errorLabel.text = "Oops! Your email is invalid."
        } else if ((passwordTextField.text?.validate(rule: minLengthRule)) != .valid) {
            errorLabel.text = "Oops! Password must be at least 8 characters."
        } else if ((confirmPasswordTextField.text?.validate(rule: equalityRule)) != .valid) {
            errorLabel.text = "Oops! Passwords don't match."
        } else {
            errorLabel.text = "Register..."
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error == nil {
                    self.errorLabel.text = "Successfully Registered!"
                    self.uid = (user?.uid)!
                    self.performSegue(withIdentifier: "registerToSetup", sender: self)
                } else {
                    self.errorLabel.text = "Failed to Register"
                }
            }
        }
        
    }
    
    @IBAction func backToLoginButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = "Let's make an account"
        self.hideKeyboardWhenTappedAround()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registerToSetup" {
            let destination = segue.destination as! SetupNameViewController
            destination.uid = uid
        }
    }
}
