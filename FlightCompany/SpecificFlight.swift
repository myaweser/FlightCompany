//
//  SpecificFlight.swift
//  FlightCompany
//
//  Created by Michele Basile on 02/12/16.
//  Copyright © 2016 Deadliners. All rights reserved.
//

import Foundation

class SpecificFlight {
    
    var key: String?
    var date: String?
    var boardingStartTime: String?
    var boardingEndTime: String?
    var price: String?
    var flight: Flight?
    
    init(date: String, boardingStartTime: String, boardingEndTime: String, price: String?, flight: Flight?) {
        self.date = date
        self.boardingStartTime = boardingStartTime
        self.boardingEndTime = boardingEndTime
        self.price = price
        self.flight = flight
    }
    
    func toAny() -> Any? {
        return [
            "date" : date!,
            "boardingStartTime" : boardingStartTime!,
            "boardingEndTime" : boardingEndTime!,
            "price" : price!
        ]
    }
    
}
