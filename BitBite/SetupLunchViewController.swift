//
//  SetupLunchViewController.swift
//  BitBite
//
//  Created by Bobby Chen on 3/11/17.
//  Copyright © 2017 BMStudios. All rights reserved.
//

import UIKit
import M13Checkbox

class SetupLunchViewController: UIViewController {
    
    var name: String?
    
    @IBOutlet weak var dialogLabel: UILabel!
    @IBOutlet weak var lunchView: UIView!

    @IBOutlet weak var sandwichCB: M13Checkbox!
    @IBOutlet weak var amerCB: M13Checkbox!
    @IBOutlet weak var mexCB: M13Checkbox!
    @IBOutlet weak var asianCB: M13Checkbox!
    @IBOutlet weak var midEastCB: M13Checkbox!

    
    @IBAction func lunchBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func lunchToDinnerButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dialogLabel.text = "Hi " + self.name!
        UIView.animate(withDuration: 1.0, delay: 0.3, options: .curveEaseOut, animations: {

        })
    }
    
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        let destinationVC = segue.destinationViewController as SetupLunchViewController
//        destinationVC.name = self.nameTextField.text
//    }
}
