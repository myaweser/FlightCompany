//
//  Flight.swift
//  FlightCompany
//
//  Created by Michele Basile on 02/12/16.
//  Copyright © 2016 Deadliners. All rights reserved.
//

import Foundation

class Flight {
    
    var key: String?
    var code: String?
    var departureTime: String?
    var arrivalTime: String?
    var departureAirport: Airport?
    var arrivalAirport: Airport?
    
    init(code: String, departureTime: String, arrivalTime: String, departureAirport: Airport, arrivalAirport: Airport) {
        self.code = code
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.departureAirport = departureAirport
        self.arrivalAirport = arrivalAirport
    }
    
    func toAny() -> Any? {
        return [
            "code" : code!,
            "departureTime" : departureTime!,
            "arrivalTime" : arrivalTime!
        ]
    }
    
}
