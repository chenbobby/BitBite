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
        if checkState(checkbox: vegetarianCB) { miscPref.append("vegetarian") }
        if checkState(checkbox: veganCB) { miscPref.append("vegan") }
        if checkState(checkbox: glutenCB) { miscPref.append("gluten") }
        
    }
    
    func checkState(checkbox: M13Checkbox) -> Bool {
        return checkbox._IBCheckState == "Checked"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 1.0, delay: 0.3, options: .curveEaseOut, animations: {
            
        })
    }
}
