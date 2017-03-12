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
import FirebaseAuth
import FirebaseDatabase

class Transportation: UIViewController {
   
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    var coordinatesString: String?
    
    var latitude: String?
    var longitude: String?
    var nameOf: String?
    var phoneNumberOf: String?
    
    var meal: String?
    var category: String?
    
    
    @IBAction func saveToHistoryButton(_ sender: Any) {
        print(self.meal)
        print(self.category)
        //performSegue(withIdentifier: "saveToHistory", sender: self)
    }

    
    @IBAction func driveMyselfPressed(_ sender: Any) {
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
        
//        self.lat.text = latitude
//        self.long.text = longitude
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveToHistory" {
            
        }
    }
    
}
