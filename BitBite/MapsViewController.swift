//
//  MapsViewController.swift
//  BitBite
//
//  Created by Michael Rojas on 3/10/17.
//  Copyright © 2017 BMStudios. All rights reserved.
//


import UIKit
import MapKit

class MapsViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager = CLLocationManager()
    var updateCount = 0
    
    

    @IBOutlet weak var mapView: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            print("Ready")
            mapView.showsUserLocation = true
            manager.startUpdatingLocation()
        } else{
            manager.requestWhenInUseAuthorization()
        }
        
        
        
    }
    
    //update location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if updateCount < 3{
                let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 1000, 1000)
                mapView.setRegion(region, animated: false)
                print("Updating Location")
                updateCount += 1
            }else{
                manager.stopUpdatingLocation()
            }
        
        
        //search the region for a term eg: Pizza, Mexican Food, etc...
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "Pizza"
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        
        //start seach
        search.start(completionHandler: {(response, error) in
            
            if error != nil {
                print("Error occured in search:\(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                
                for item in response!.mapItems {
                    
                    print("Name = \(item.name)")
                    print("Phone = \(item.phoneNumber)")
                    
                    //add the annotations to map
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.mapView.addAnnotation(annotation)
                }
            }
        })
        
    }
    //recenter button pressed
    @IBAction func recenterButtonPressed(_ sender: Any) {
        if let coord = manager.location?.coordinate{
        let region = MKCoordinateRegionMakeWithDistance(coord, 1000, 1000)
        mapView.setRegion(region, animated: false)
        print("Recenter Location")
        }
    }
    
    
    
    
    

}
