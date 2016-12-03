//
//  Flights.swift
//  FlightCompany
//
//  Created by Michele Basile on 02/12/16.
//  Copyright © 2016 Deadliners. All rights reserved.
//

import Foundation
import Firebase

class Flights {
    
    let databaseRef: FIRDatabaseReference = FIRDatabase.database().reference(withPath: "flights")
    
    static let shared = Flights()
    private init() {}
    
    func store(flight: Flight) {
        
        // Saving flights in its tree (rembember to flat your data!)
        flight.key = databaseRef.childByAutoId().key
        databaseRef.child(flight.key!).setValue(flight.toAny())
        
        // Get the references for arrivals and departures in airport tree
        let arrivalAirportRef = FIRDatabase.database().reference(withPath: "airports/\(flight.arrivalAirport!.key!)/arrivalFlights")
        let departureAirportRef = FIRDatabase.database().reference(withPath: "airports/\(flight.departureAirport!.key!)/departureFlights")
        
        // Push flight key into airport tree
        arrivalAirportRef.updateChildValues([flight.key! : true])
        departureAirportRef.updateChildValues([flight.key! : true])
    }
    
}
