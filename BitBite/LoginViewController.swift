//
//  ViewController.swift
//  BitBite
//
//  Created by Bobby Chen on 3/10/17.
//  Copyright © 2017 BMStudios. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    @IBAction func loginButton(_ sender: Any) {
        print("trying to log in")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

