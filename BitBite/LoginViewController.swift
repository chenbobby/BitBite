//
//  ViewController.swift
//  BitBite
//
//  Created by Bobby Chen on 3/10/17.
//  Copyright © 2017 BMStudios. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
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
                    self.checkAccountSetup()
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
        
        if FIRAuth.auth()?.currentUser != nil {
            checkAccountSetup()
        }
    }
    
    func checkAccountSetup() {
        let ref = FIRDatabase.database().reference().child("users")
        ref.child((FIRAuth.auth()?.currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshotValue = snapshot.value as? NSDictionary {
                self.performSegue(withIdentifier: "login", sender: self)
            } else {
                self.performSegue(withIdentifier: "goSetup", sender: self)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goSetup" {
            let destination = segue.destination as! SetupNameViewController
            destination.uid = FIRAuth.auth()?.currentUser?.uid
        }
    }

}

