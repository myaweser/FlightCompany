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
    var tickets: [Ticket]?
    var boarding: [SpecificFlight]?
    
    init(id: String?, email: String?, password: String?, name: String?, surname: String?) {
        self.id = id
        self.email = email
        self.password = password
        self.name = name
        self.surname = surname
    }
    
    convenience init(from passenger: Passenger) {
        self.init(id: passenger.id,
                  email: passenger.email,
                  password: passenger.password,
                  name: passenger.name,
                  surname: passenger.surname)
    }
    
}
