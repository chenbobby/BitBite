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
    @IBOutlet weak var phoneNumber: UILabel!
    
    @IBAction func driveMyselfPressed(_ sender: Any) {
        let testURL = URL(string: "comgooglemaps-x-callback://")!
        if UIApplication.shared.canOpenURL(testURL) {
            let directionsRequest = "comgooglemaps-x-callback://" +
                "?daddr=John+F.+Kennedy+International+Airport,+Van+Wyck+Expressway,+Jamaica,+New+York" +
            "&x-success=sourceapp://?resume=true&x-source=AirApp"
            
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
        
        self.lat.text = latitude
        self.long.text = longitude
        self.name.text = nameOf
        self.phoneNumber.text = phoneNumberOf
        
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
    
    var latitude: String?
    var longitude: String?
    var nameOf: String?
    var phoneNumberOf: String?
    
    
}
