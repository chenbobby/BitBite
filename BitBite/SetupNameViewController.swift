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
    
    
    @IBOutlet weak var dialogLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nameToLunchButton: UIButton!

    @IBAction func nameToLunchButton(_ sender: Any) {
        errorLabel.text = ""
        
        let minLengthRule = ValidationRuleLength(min: 1, error: NSError())
        let validCharSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789 ")
        let nonwhiteCharSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789")
        
        if (nameTextField.text?.validate(rule: minLengthRule) != .valid && nameTextField.text?.rangeOfCharacter(from: nonwhiteCharSet) != nil) {
            errorLabel.text = "Please enter a name"
        } else if (nameTextField.text?.rangeOfCharacter(from: validCharSet.inverted) != nil) {
            errorLabel.text = "That name looks kinda weird..."
        } else {
            errorLabel.text = ""
            performSegue(withIdentifier: "nameToLunch", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.errorLabel.text = ""
        
        self.dialogLabel.alpha = 0
        self.nameLabel.alpha = 0
        self.nameTextField.alpha = 0
        self.errorLabel.alpha = 0
        self.nameToLunchButton.alpha = 0
        
        UIView.animate(withDuration: 1.0, delay: 0.3, options: .curveEaseOut, animations: {
            self.dialogLabel.center.y += 2.5*(self.dialogLabel.bounds.height)
            self.dialogLabel.alpha = 1.0
        })
        
        UIView.animate(withDuration: 1.0, delay: 1.3, options: .curveEaseOut, animations: {
            self.nameLabel.center.x -= self.view.bounds.width
            self.nameTextField.center.x -= self.view.bounds.width
            self.errorLabel.center.x -= self.view.bounds.width
            self.nameToLunchButton.center.x -= self.view.bounds.width
            self.nameLabel.alpha = 1.0
            self.nameTextField.alpha = 1.0
            self.errorLabel.alpha = 1.0
            self.nameToLunchButton.alpha = 1.0
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preparing")
        if segue.identifier == "nameToLunch" {
            let destination = segue.destination as! SetupLunchViewController
            destination.name = self.nameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
}
