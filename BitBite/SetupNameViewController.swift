//
//  SetupViewController.swift
//  BitBite
//
//  Created by Bobby Chen on 3/11/17.
//  Copyright © 2017 BMStudios. All rights reserved.
//

import UIKit
import Validator

class SetupNameViewController: UIViewController {
    
    var uid: String?
    
    @IBOutlet weak var dialogLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nameToLunchButton: UIButton!

    @IBAction func nameToLunchButton(_ sender: Any) {
        errorLabel.text = ""
        
        //create validation rules and valid character sets for NAME
        let minLengthRule = ValidationRuleLength(min: 1, error: NSError())
        let validCharSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789 ")
        let nonwhiteCharSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789")
        
        if (nameTextField.text?.validate(rule: minLengthRule) != .valid || nameTextField.text?.rangeOfCharacter(from: nonwhiteCharSet) == nil) {
            errorLabel.text = "Please enter a name"
        } else if (nameTextField.text?.rangeOfCharacter(from: validCharSet.inverted) != nil) {
            errorLabel.text = "That name has invalid characters..."
        } else {
            //no errors; proceed
            errorLabel.text = ""
            performSegue(withIdentifier: "nameToLunch", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.errorLabel.text = ""
    }
    
    //send data to next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nameToLunch" {
            let destination = segue.destination as! SetupLunchViewController
            destination.uid = uid
            destination.name = self.nameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
}
