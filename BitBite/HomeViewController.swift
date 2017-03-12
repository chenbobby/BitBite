//
//  HomeViewController.swift
//  BitBite
//
//  Created by Michael Rojas on 3/10/17.
//  Copyright © 2017 BMStudios. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lunchView: UIView!
    @IBOutlet weak var dinnerView: UIView!
    @IBOutlet weak var barsView: UIView!
    
    var userRef: FIRDatabaseReference?
    
    var query = [String]()
    
    @IBAction func logoutButton(_ sender: Any) {
        let alert = UIAlertController(title: "Logging out", message: "Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Logout", style: UIAlertActionStyle.default, handler: { action in
            if action.style == .default {
            try! FIRAuth.auth()?.signOut()
            self.dismiss(animated: true, completion: nil)
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userRef = FIRDatabase.database().reference().child("users/" + (FIRAuth.auth()?.currentUser?.uid)!)
        
        self.userRef?.child("name").observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshotValue = snapshot.value as? String {
                self.nameLabel.text = snapshotValue
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
            
        
        lunchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapLunch(_:))))
        dinnerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapDinner(_:))))
        barsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapBars(_:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.resetQueryWithMisc()
    }
    
    func resetQueryWithMisc() {
        self.query = []
        
        //fetch user's misc into query[]
        self.userRef?.child("misc").observeSingleEvent(of: .value, with: { (snapshot) in
            let snapshotValue = snapshot.value as? [String : Bool]
            
            for (key, value) in snapshotValue! {
                if value { self.query.append(key)}
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    //generate rand num between upper and lower
    func randRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    
    //randomly choose from lunch preferences into query[]
    func tapLunch(_ sender: UITapGestureRecognizer) {
        self.resetQueryWithMisc()
        
        self.userRef?.child("lunch").observeSingleEvent(of: .value, with: { (snapshot) in
            let snapshotValue = snapshot.value as? [String : Int]
            
            var cumulative = [String]()
            for (key, value) in snapshotValue! {
                if value > 0 {
                    for _ in 1...value {
                        cumulative.append(key)
                    }
                }
            }
            self.query.append(cumulative[self.randRange(lower: 0, upper: (cumulative.count-1))])
            self.performSegue(withIdentifier: "toMapSearch", sender: self)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func tapDinner(_ sender: UITapGestureRecognizer) {
        self.resetQueryWithMisc()
        
        self.userRef?.child("dinner").observeSingleEvent(of: .value, with: { (snapshot) in
            let snapshotValue = snapshot.value as? [String : Int]
            
            var cumulative = [String]()
            for (key, value) in snapshotValue! {
                if value > 0 {
                    for _ in 1...value {
                        cumulative.append(key)
                    }
                }
            }
            self.query.append(cumulative[self.randRange(lower: 0, upper: (cumulative.count-1))])
            self.performSegue(withIdentifier: "toMapSearch", sender: self)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func tapBars(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toBars", sender: self)
    }
    
    //return single string to be queried on maps view
    func formatQuery() -> String {
        var formattedQuery = [String]()
        
        for keyword in self.query {
            switch keyword {
            case "sandwich":
                formattedQuery.append("sandwiches")
                break
            case "amer":
                formattedQuery.append("fast food")
                break
            case "mex":
                formattedQuery.append("mexican food")
                break
            case "asian":
                formattedQuery.append("chinese food")
                break
            case "midEast":
                formattedQuery.append("middle eastern food")
                break
            case "italian":
                formattedQuery.append("italian food")
                break
            case "steak":
                formattedQuery.append("steakhouses")
                break
            case "vegetarian":
                formattedQuery.append("vegetarian")
                break
            case "vegan":
                formattedQuery.append("vegan")
                break
            case "gluten":
                formattedQuery.append("gluten free")
                break
            default:
                break
            }
        }
        return formattedQuery.joined(separator: " ")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapSearch" {
            let destination = segue.destination as! MapsViewController
            destination.query = self.formatQuery()
        } else if segue.identifier == "toBars" {
            let destination = segue.destination as! MapsViewController
            destination.query = "bars"
        }
    }

}
