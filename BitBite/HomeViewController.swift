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

    @IBOutlet weak var lunchView: UIView!
    @IBOutlet weak var lunchFriendView: UIView!
    @IBOutlet weak var lunchHistoryView: UIView!
    @IBOutlet weak var dinnerView: UIView!
    @IBOutlet weak var dinnerFriendView: UIView!
    @IBOutlet weak var dinnerHistoryView: UIView!
    
    var userRef: FIRDatabaseReference?
    
    var query = [String]()
    
    @IBAction func logoutButton(_ sender: Any) {
        try! FIRAuth.auth()?.signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userRef = FIRDatabase.database().reference().child("users/" + (FIRAuth.auth()?.currentUser?.uid)!)
        
        lunchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapLunch(_:))))
        lunchFriendView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapLunchFriends(_:))))
        lunchHistoryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapLunchHistory(_:))))
        dinnerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapDinner(_:))))
        dinnerFriendView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapDinnerFriends(_:))))
        dinnerHistoryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapDinnerHistory(_:))))
        
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
            
            print(self.formatQuery())
            
        }) { (error) in
            print(error.localizedDescription)
        }
        print("tapped lunch")
        //performSegue(withIdentifier: "toMapSearch", sender: self)
    }
    
    func tapLunchFriends(_ sender: UITapGestureRecognizer) {
        print("tapped lunch friends")
    }
    
    func tapLunchHistory(_ sender: UITapGestureRecognizer) {
        print("tapped lunch history")
    }
    
    func tapDinner(_ sender: UITapGestureRecognizer) {
        print("tapped dinner")
    }
    
    func tapDinnerFriends(_ sender: UITapGestureRecognizer) {
        print("tapped dinner friends")
    }
    
    func tapDinnerHistory(_ sender: UITapGestureRecognizer) {
        print("tapped dinner history")
    }
    
    //return single string to be queried on maps view
    func formatQuery() -> String {
        var formattedQuery = [String]()
        
        for keyword in self.query {
            switch keyword {
            case "sandwich":
                formattedQuery.append("sandwich")
                break
            case "amer":
                formattedQuery.append("fast")
                break
            case "mex":
                formattedQuery.append("mexican")
                break
            case "asian":
                formattedQuery.append("chinese")
                break
            case "midEast":
                formattedQuery.append("middle eastern")
                break
            case "italian":
                formattedQuery.append("italian")
                break
            case "steak":
                formattedQuery.append("steak")
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
        
        formattedQuery.append("food")
        return formattedQuery.joined(separator: " ")
    }

}
