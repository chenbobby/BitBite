//
//  SetupDinnerViewController2.swift
//  BitBite
//
//  Created by Bobby Chen on 3/12/17.
//  Copyright © 2017 BMStudios. All rights reserved.
//

import UIKit
import M13Checkbox

class SetupDinnerViewController2: UIViewController {
    
    var uid: String?
    var name: String?
    var lunchPref: [String]?
    var dinnerPref = [String]()
    
    
    @IBOutlet weak var italianCB: M13Checkbox!
    @IBOutlet weak var steakCB: M13Checkbox!
    @IBOutlet weak var mexCB: M13Checkbox!
    @IBOutlet weak var asianCB: M13Checkbox!
    @IBOutlet weak var midEastCB: M13Checkbox!

    @IBAction func dinnerBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dinnerToMiscButton(_ sender: Any) {
        //add strings dinnerPref[] if the checkbox was checked
        if checkState(checkbox: italianCB) { dinnerPref.append("italian") }
        if checkState(checkbox: steakCB) { dinnerPref.append("steak") }
        if checkState(checkbox: mexCB) { dinnerPref.append("mex") }
        if checkState(checkbox: asianCB) { dinnerPref.append("asian") }
        if checkState(checkbox: midEastCB) { dinnerPref.append("midEast") }
        
        performSegue(withIdentifier: "dinnerToMisc", sender: self)
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
    
    override func viewWillAppear(_ animated: Bool) {
        dinnerPref = []
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dinnerToMisc" {
            let destination = segue.destination as! SetupMiscViewController
            destination.uid = uid
            destination.name = name
            destination.lunchPref = lunchPref
            destination.dinnerPref = dinnerPref
        }
        
    }
}
