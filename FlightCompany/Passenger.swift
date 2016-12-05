//
//  Passenger.swift
//  FlightCompany
//
//  Created by Michele Basile on 27/11/16.
//  Copyright © 2016 Deadliners. All rights reserved.
//

import Foundation

class Passenger {
    
    var id: String?
    var email: String?
    var password: String?
    var name: String?
    var surname: String?
    
    init(email: String?, password: String?, name: String?, surname: String?) {
        self.email = email
        self.password = password
        self.name = name
        self.surname = surname
    }
    
}
