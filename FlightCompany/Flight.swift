//
//  Flight.swift
//  FlightCompany
//
//  Created by Michele Basile on 02/12/16.
//  Copyright © 2016 Deadliners. All rights reserved.
//

import Foundation
import Firebase

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
    
    init(snapshot: FIRDataSnapshot) {
        self.key = snapshot.key
        let snapValue = snapshot.value as! [String : AnyObject]
        self.departureTime = snapValue["departureTime"] as? String
        self.arrivalTime = snapValue["arrivalTime"] as? String
    }
    
    func toAny() -> Any? {
        return [
            "code" : code!,
            "departureTime" : departureTime!,
            "arrivalTime" : arrivalTime!,
            "departureAirport" : departureAirport!.key!,
            "arrivalAirport" : arrivalAirport!.key!,
            "departureArrivalAirportKeys" : departureAirport!.key! + arrivalAirport!.key!
        ]
    }
    
}
