//
//  SetupViewController.swift
//  BitBite
//
//  Created by Bobby Chen on 3/11/17.
//  Copyright © 2017 BMStudios. All rights reserved.
//

import UIKit
import Firebase
import M13Checkbox

class SetupViewController: UIViewController {
    
    
    @IBOutlet weak var NameView: UIView!
    @IBOutlet weak var LunchView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lunchSandCB: M13Checkbox!
    @IBOutlet weak var lunchAmerCB: M13Checkbox!
    @IBOutlet weak var lunchMexCB: M13Checkbox!
    @IBOutlet weak var lunchAsianCB: M13Checkbox!
    @IBOutlet weak var lunchMidEastCB: M13Checkbox!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //figure out how to start it off screen
        var lunchFrame = self.LunchView.frame
        lunchFrame.origin.x += 1.5*(lunchFrame.size.width)
        self.LunchView.frame = lunchFrame
        
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseOut, animations: {
            var nameFrame = self.NameView.frame
            nameFrame.origin.x += 1.5*(nameFrame.size.width)
            self.NameView.frame = nameFrame
            
            
        }, completion: { finished in
            print("Finished Animation")
        })
    }
    
    func nameToLunch() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            var nameLeftFrame = self.NameView.frame
            nameLeftFrame.origin.x += 1.5*(nameLeftFrame.size.width)
            self.NameView.frame = nameLeftFrame
            
            var lunchRightFrame = self.LunchView.frame
            lunchRightFrame.origin.x += 1.5*(lunchRightFrame.size.width)
            self.LunchView.frame = lunchRightFrame
        }, completion: { finished in
            print("Finished Animation")
        })
    }
    
    func checkState(checkbox: M13Checkbox) -> Bool {
        return checkbox._IBCheckState == "Checked"
    }
}
