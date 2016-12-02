//
//  SpecificFlights.swift
//  FlightCompany
//
//  Created by Michele Basile on 02/12/16.
//  Copyright © 2016 Deadliners. All rights reserved.
//

import Foundation
import Firebase

class SpecificFlights {
    
    
    let databaseRef: FIRDatabaseReference = FIRDatabase.database().reference(withPath: "specificFlights")
    
    static let shared = SpecificFlights()
    private init() {}
    
    func store(specificFlight: SpecificFlight) {

        // Saving flights in its tree (rembember to flat your data!)
        specificFlight.key = databaseRef.childByAutoId().key
        databaseRef.child(specificFlight.key!).setValue(specificFlight.toAny())
        
        // Get the reference for flight where we are pushing specific flight key
        let flightRef = FIRDatabase.database().reference(withPath: "flights/\(specificFlight.flight!.key!)/specificFlights")
        
        // Push flight key into airport tree
        flightRef.updateChildValues([specificFlight.key! : true])
        
    }
    
}
