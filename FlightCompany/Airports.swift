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
    
    func getAll(completion: @escaping ([Airport]) -> Void) {
        databaseRef.observe(.value, with: { snapshot in
            var airports: [Airport] = []
            for child in snapshot.children {
                let airport = Airport(snapshot: child as! FIRDataSnapshot)
                airports.append(airport)
            }
            completion(airports)
        })
    }
    
}
