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

    
    init(title: String, phoneNumber: String?) {
        
        self.title = title
        self.phoneNumber = phoneNumber

        
    }
}
