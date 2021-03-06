//
//  Transportation.swift
//  BitBite
//
//  Created by Michael Rojas on 3/11/17.
//  Copyright © 2017 BMStudios. All rights reserved.
//

import UIKit
import UberRides
import CoreLocation

class Transportation: UIViewController {
   
    @IBOutlet weak var lat: UILabel!
 
    @IBOutlet weak var long: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var phoneNumber: UILabel!
    
    var coordinatesString: String?
    
    var latitude: String?
    var longitude: String?
    var nameOf: String?
    var phoneNumberOf: String?
    
    @IBAction func saveHistoryButton(_ sender: Any) {
        saveButton.setTitle("Saving...", for: .disabled)
        saveButton.isEnabled = false
        sleep(1)
        saveButton.setTitle("Meal saved.", for: .disabled)
        
    }
    
    @IBAction func openGoogleMapsButton(_ sender: Any) {
        let testURL = URL(string: "comgooglemaps-x-callback://")!
        if UIApplication.shared.canOpenURL(testURL) {
            let directionsRequest = "comgooglemapsurl://maps.google.com/?q="  + self.coordinatesString! +
            "&x-source=SourceApp&x-success=sourceapp://?resume=true"
            
            let directionsURL = URL(string: directionsRequest)!
            UIApplication.shared.openURL(directionsURL)
        } else {
            NSLog("Can't use comgooglemaps-x-callback:// on this device.")
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.name.text = nameOf
        self.phoneNumber.text = phoneNumberOf
        
        coordinatesString = latitude! + "," + longitude!
        
        // ride request button
        let button = RideRequestButton()
        
        // set a dropoffLocation
        let dropoffLocation = CLLocation(latitude: Double(latitude!)!, longitude: Double(longitude!)!)
        let builder = RideParametersBuilder()
            .setDropoffLocation(dropoffLocation,
                                nickname: nameOf)
        button.rideParameters = builder.build()
        
        // center button
        button.center = view.center
        
        //put the button in the view
        view.addSubview(button)
    }
    
}
