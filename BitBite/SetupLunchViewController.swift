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
    
    var uid: String?
    var name: String?
    var lunchPref = [String]()
    
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
        
        //add strings lunchPref[] if the checkbox was checked
        if checkState(checkbox: sandwichCB) { lunchPref.append("sandwich") }
        if checkState(checkbox: amerCB) { lunchPref.append("amer") }
        if checkState(checkbox: mexCB) { lunchPref.append("mex") }
        if checkState(checkbox: asianCB) { lunchPref.append("asian") }
        if checkState(checkbox: midEastCB) { lunchPref.append("midEast") }
        
        performSegue(withIdentifier: "lunchToDinner", sender: self)
    }
    
    //helper function to return Bool from checkboxes
    func checkState(checkbox: M13Checkbox) -> Bool {
        return checkbox._IBCheckState == "Checked"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        dialogLabel.text = "Hi " + self.name!
        lunchPref = []
    }
    
    //send data to next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "lunchToDinner" {
//            let destination = segue.destination as! SetupDinnerViewController
//            destination.uid = uid
//            destination.name = self.name
//            destination.lunchPref = lunchPref
//        }

    }
}
