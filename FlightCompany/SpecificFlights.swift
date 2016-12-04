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
    
    func get(from departureAirport: Airport, to arrivalAirport: Airport, dateFrom: String, completion: @escaping ([SpecificFlight]) -> Void) {
        
        var specificFlightsList: [SpecificFlight] = []
        
        Flights.shared.databaseRef
            .queryOrdered(byChild: "departureArrivalAirportKeys")
            .queryEqual(toValue: departureAirport.key! + arrivalAirport.key!)
            .observeSingleEvent(of: .value, with: { flightsSnap in
                
                var flightIteration: UInt = 1
                var specificFlightIteration: UInt = 0
                
                for flightChild in flightsSnap.children {
                    
                    // Create a flight object from a snapshot child
                    let flightChildSnap = flightChild as! FIRDataSnapshot
                    let flight = Flight(snapshot: flightChildSnap, departureAirport: departureAirport, arrivalAirport: arrivalAirport)
                    
                    // Retrieve specific flight keys (a flight could have more specificFlights)
                    let flightChildSnapValue = flightChildSnap.value as! [String : AnyObject]
                    let specificFlightsKeys = flightChildSnapValue["specificFlights"] as! [String : Bool]
                
                    
                    // Retrieve specific flight objects
                    
                    let numberOfSpecificFlights = UInt(specificFlightsKeys.count)
                    
                    for (specificFlightKey, _) in specificFlightsKeys {
                        self.databaseRef.child(specificFlightKey)
                            .observeSingleEvent(of: .value, with: { specificFlightSnap in
                                
                                // Iteration tracking
                                specificFlightIteration += 1
                                if specificFlightIteration > numberOfSpecificFlights {
                                    specificFlightIteration = 1
                                    flightIteration += 1
                                }
                                
                                let specificFlightSnapValue = specificFlightSnap.value as! [String : String]
                                if specificFlightSnapValue["date"]! >= dateFrom {
                                    let specificFlight = SpecificFlight(snapshot: specificFlightSnap, flight: flight)
                                    specificFlightsList.append(specificFlight)
                                }
                                // Completion call if we get all entries
                                if flightIteration == flightsSnap.childrenCount && specificFlightIteration == numberOfSpecificFlights {
                                    completion(specificFlightsList)
                                }
            
                            })
                    }
                    
                }
            })
    }
    
}
