//
//  Airports.swift
//  FlightCompany
//
//  Created by Michele Basile on 02/12/16.
//  Copyright © 2016 Deadliners. All rights reserved.
//

import Foundation
import Firebase

class Airports {
    
    let databaseRef: FIRDatabaseReference = FIRDatabase.database().reference(withPath: "airports")
    
    static let shared = Airports()
    private init() {}
    
    func store(airport: Airport) {
        airport.key = databaseRef.childByAutoId().key
        databaseRef.child(airport.key!).setValue(airport.toAny())
    }
    
}
