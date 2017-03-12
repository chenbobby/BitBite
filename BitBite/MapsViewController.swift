//
//  MapsViewController.swift
//  BitBite
//
//  Created by Michael Rojas on 3/10/17.
//  Copyright © 2017 BMStudios. All rights reserved.
//


import UIKit
import MapKit


class MapsViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var queryLabel: UILabel!
    var manager = CLLocationManager()
    var updateCount = 0
    var restaurantItems = [RestaurantItem]()
    let cellIdentifier = "MapViewCell"
    var testArray = [String]()
    var count = 0
    
    var latitude = String()
    var longitude = String()
    var name = String()
    var phoneNumber = String()
    
    var query: String?
    var meal: String?
    var category: String?
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var mapItem: UILabel!
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBAction func mapsBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.queryLabel.text = self.query
        manager.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.backgroundColor = UIColorFromRGB(rgbValue: 0x119E98)
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            print("Ready")
            mapView.showsUserLocation = true
            manager.startUpdatingLocation()
        } else{
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
        
        
    }
    
    
    
    //update location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if updateCount < 3 {
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 3000, 3000)
            mapView.setRegion(region, animated: false)
            print("Updating Location")
            updateCount += 1
        } else {
            manager.stopUpdatingLocation()
        }
        
        
        
        //search the region for a term eg: Pizza, Mexican Food, etc...
        let request = MKLocalSearchRequest()
        //replace this with data passed from the food picking algorithm
        
        request.naturalLanguageQuery = self.query
        request.region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 3000, 3000)
        let search = MKLocalSearch(request: request)
        
        //start seach
        search.start(completionHandler: {(response, error) in
            if error != nil {
                print("Error occured in search:\(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else if self.count < 1 {
                print("Matches found")
                
                for item in response!.mapItems {
                    
                    print("Name = \(item.name)")
                    print("Phone = \(item.phoneNumber)")
                    print("Latitude = \(item.placemark.coordinate.latitude)")
                    self.testArray.append(String(item.name!))
                    self.tableView.reloadData()
                    self.restaurantItems.append(RestaurantItem(title: item.name!, phoneNumber: item.phoneNumber, latitude: String(item.placemark.coordinate.latitude), longitude: String(item.placemark.coordinate.longitude)))
                    
                    
                    //add the annotations to map
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.mapView.addAnnotation(annotation)
                    
                }
                self.count += 1
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! Transportation
        destination.latitude = latitude
        destination.longitude = longitude
        destination.nameOf = name
        destination.phoneNumberOf = phoneNumber
        destination.meal = self.meal
        destination.category = self.category
    }
    
    //recenter button pressed
    @IBAction func centerButtonPressed(_ sender: Any) {
        if let coord = manager.location?.coordinate{
            let region = MKCoordinateRegionMakeWithDistance(coord, 3000, 3000)
            mapView.setRegion(region, animated: false)
            print("Recenter Location")
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = UITableViewCell()
//        cell.textLabel?.text = testArray[indexPath.row]
       let restaurant = restaurantItems[indexPath.row]
       cell.textLabel?.text = restaurant.title
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        latitude = restaurantItems[indexPath.row].latitude
        longitude = restaurantItems[indexPath.row].longitude
        name = restaurantItems[indexPath.row].title
        //phoneNumber = restaurantItems[indexPath.row].phoneNumber
        performSegue(withIdentifier: "goToTransportation", sender: self)
    }
    

        
}
