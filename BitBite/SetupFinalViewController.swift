//
//  SetupFinalViewController.swift
//  BitBite
//
//  Created by Bobby Chen on 3/11/17.
//  Copyright © 2017 BMStudios. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SetupFinalViewController: UIViewController {
    
    var uid: String?
    var name: String?
    var lunchPref: [String]?
    var dinnerPref: [String]?
    var miscPref: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateAccount()
        print("done finishing")
        self.performSegue(withIdentifier: "finishSetup", sender: self)
    }
    
    
    func updateAccount() {
        var userRef: FIRDatabaseReference!
        userRef = FIRDatabase.database().reference().child("users/" + self.uid!)
        
        userRef.child("name").setValue(name)
        
        let lunchRef = userRef.child("lunch")
        checkAndPostPref(pref: lunchPref!, ref: lunchRef, category: "sandwich")
        checkAndPostPref(pref: lunchPref!, ref: lunchRef, category: "amer")
        checkAndPostPref(pref: lunchPref!, ref: lunchRef, category: "mex")
        checkAndPostPref(pref: lunchPref!, ref: lunchRef, category: "asian")
        checkAndPostPref(pref: lunchPref!, ref: lunchRef, category: "midEast")
        
        let dinnerRef = userRef.child("dinner")
        checkAndPostPref(pref: dinnerPref!, ref: dinnerRef, category: "italian")
        checkAndPostPref(pref: dinnerPref!, ref: dinnerRef, category: "steak")
        checkAndPostPref(pref: dinnerPref!, ref: dinnerRef, category: "mex")
        checkAndPostPref(pref: dinnerPref!, ref: dinnerRef, category: "asian")
        checkAndPostPref(pref: dinnerPref!, ref: dinnerRef, category: "midEast")
        
        let miscRef = userRef.child("misc")
        checkAndPostPref(pref: miscPref!, ref: miscRef, category: "vegetarian")
        checkAndPostPref(pref: miscPref!, ref: miscRef, category: "vegan")
        checkAndPostPref(pref: miscPref!, ref: miscRef, category: "gluten")
    }
    
    
    //helper function for checking contents of prefs and updating Firebase
    func checkAndPostPref(pref: [String], ref: FIRDatabaseReference, category: String) {
        
        switch pref == miscPref! {
        case true:
            //pref is about misc; assign Bool
            if pref.contains(category) {
                ref.child(category).setValue(true)
            } else {
                ref.child(category).setValue(false)
            }
            break
        case false:
            //pref is about lunch or dinner; assign Ints
            if pref.contains(category) {
                ref.child(category).setValue(3)
            } else {
                ref.child(category).setValue(0)
            }
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finishSetup" {
            
        }
    }
}
