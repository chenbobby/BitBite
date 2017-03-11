//
//  RegisterViewController.swift
//  BitBite
//
//  Created by Michael Rojas on 3/10/17.
//  Copyright © 2017 BMStudios. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        
        
    }
    
    @IBAction func backToLoginButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
