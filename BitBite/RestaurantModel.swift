//
//  RestaurantModel.swift
//  BitBite
//
//  Created by Michael Rojas on 3/11/17.
//  Copyright © 2017 BMStudios. All rights reserved.
//

import UIKit

class RestaurantItem {
    
    var title: String!
    var phoneNumber: String!
    var latitude: String!
    var longitude: String!

    
    init(title: String, phoneNumber: String?, latitude: String!, longitude: String!) {
        
        self.title = title
        self.phoneNumber = phoneNumber
        self.latitude = latitude
        self.longitude = longitude

        
    }
}
