//
//  SetupMiscViewController.swift
//  BitBite
//
//  Created by Bobby Chen on 3/11/17.
//  Copyright © 2017 BMStudios. All rights reserved.
//

import UIKit
import M13Checkbox

class SetupMiscViewController: UIViewController {
    
    var uid: String?
    var name: String?
    var lunchPref: [String]?
    var dinnerPref: [String]?
    var miscPref = [String]()
    
    @IBOutlet weak var dialogLabel: UILabel!
    @IBOutlet weak var miscView: UIView!
    @IBOutlet weak var vegetarianCB: M13Checkbox!
    @IBOutlet weak var veganCB: M13Checkbox!
    @IBOutlet weak var glutenCB: M13Checkbox!
    
    @IBAction func miscBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func miscFinishButton(_ sender: Any) {
        
        //add strings miscPref[] if the checkbox was checked
        if checkState(checkbox: vegetarianCB) { miscPref.append("vegetarian") }
        if checkState(checkbox: veganCB) { miscPref.append("vegan") }
        if checkState(checkbox: glutenCB) { miscPref.append("gluten") }
        
        performSegue(withIdentifier: "miscToFinal", sender: self)
    }
    
    //helper function to return Bool from checkboxes
    func checkState(checkbox: M13Checkbox) -> Bool {
        return checkbox._IBCheckState == "Checked"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 1.0, delay: 0.3, options: .curveEaseOut, animations: {
            
        })
    }
    
    //send data to next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "miscToFinal" {
            let destination = segue.destination as! SetupFinalViewController
            destination.uid = uid
            destination.name = name
            destination.lunchPref = lunchPref
            destination.dinnerPref = dinnerPref
            destination.miscPref = miscPref
        }
        
    }
}
