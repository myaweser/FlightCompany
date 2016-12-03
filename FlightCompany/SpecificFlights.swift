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
                var flightsIteration: UInt = 0
                for flightChild in flightsSnap.children {
                    let flight = Flight(snapshot: flightChild as! FIRDataSnapshot)
                    self.databaseRef
                        .queryOrdered(byChild: "flight")
                        .queryEqual(toValue: flight.key!)
                        .observeSingleEvent(of: .value, with: { specificFlightsSnap in
                            flightsIteration += 1
                            var specificFlightsIteration: UInt = 0
                            for specificFlightChild in specificFlightsSnap.children {
                                specificFlightsIteration += 1
                                let specificFlight = SpecificFlight(snapshot: specificFlightChild as! FIRDataSnapshot, flight: flight)
                                specificFlightsList.append(specificFlight)
                                if flightsIteration == flightsSnap.childrenCount && specificFlightsIteration == specificFlightsSnap.childrenCount {
                                    // we got all the specific flight entries
                                    completion(specificFlightsList)
                                }
                            }
                        })
                }
            })
    }
    
}
