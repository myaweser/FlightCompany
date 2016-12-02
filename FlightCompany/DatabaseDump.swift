//
//  DatabaseDump.swift
//  FlightCompany
//
//  Created by Michele Basile on 02/12/16.
//  Copyright © 2016 Deadliners. All rights reserved.
//

import Foundation

class DatabaseDump {
    
    var airportsDump: [Airport]
    var flightsDump: [Flight]
    var specificFlightDump: [SpecificFlight]
    
    static let shared = DatabaseDump()
    
    private init() {
        
        airportsDump = [
            Airport(code: "NAPLES001", locality: "Naples"),
            Airport(code: "ROME002", locality: "Rome"),
            Airport(code: "NEWYORK005", locality: "New York"),
            Airport(code: "PARIS008", locality: "Paris"),
            Airport(code: "BERLIN004", locality: "Berlin"),
        ]
        flightsDump = [
            // Rome -> Paris
            Flight(code: "FLIGHT001", departureTime: "10:00", arrivalTime: "11:10", departureAirport: airportsDump[1], arrivalAirport: airportsDump[3]),
            Flight(code: "FLIGHT002", departureTime: "13:00", arrivalTime: "14:10", departureAirport: airportsDump[1], arrivalAirport: airportsDump[3]),
            Flight(code: "FLIGHT003", departureTime: "16:00", arrivalTime: "17:10", departureAirport: airportsDump[1], arrivalAirport: airportsDump[3]),
            // Naples -> New York
            Flight(code: "FLIGHT004", departureTime: "15:00", arrivalTime: "23:00", departureAirport: airportsDump[0], arrivalAirport: airportsDump[2]),
        ]
        specificFlightDump = [
            SpecificFlight(date: "2016/12/22", boardingStartTime: "09:00", boardingEndTime: "09:45", price: "100 €", flight: flightsDump[0]), // FLIGHT001
            SpecificFlight(date: "2016/12/22", boardingStartTime: "12:00", boardingEndTime: "12:45", price: "110 €", flight: flightsDump[1]), // FLIGHT002
            SpecificFlight(date: "2016/12/22", boardingStartTime: "15:00", boardingEndTime: "15:45", price: "150 €", flight: flightsDump[2]), // FLIGHT003
            SpecificFlight(date: "2016/12/23", boardingStartTime: "09:00", boardingEndTime: "09:45", price: "100 €", flight: flightsDump[0]), // FLIGHT001
            SpecificFlight(date: "2016/12/24", boardingStartTime: "08:30", boardingEndTime: "09:45", price: "200 €", flight: flightsDump[0]), // FLIGHT001
        ]
    }
    
    func populate() {
        
        for airport in airportsDump {
            Airports.shared.store(airport: airport)
        }
        
        for flight in flightsDump {
            Flights.shared.store(flight: flight)
        }
        
        
        
    }
    
    
}
