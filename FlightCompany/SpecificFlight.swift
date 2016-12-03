//
//  SpecificFlight.swift
//  FlightCompany
//
//  Created by Michele Basile on 02/12/16.
//  Copyright © 2016 Deadliners. All rights reserved.
//

import Foundation
import Firebase

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
    
    init(snapshot: FIRDataSnapshot, flight: Flight) {
        self.key = snapshot.key
        let snapValue = snapshot.value as! [String : AnyObject]
        self.date = snapValue["date"] as? String
        self.boardingStartTime = snapValue["boardingStartTime"] as? String
        self.boardingEndTime = snapValue["boardingEndTime"] as? String
        self.price = snapValue["price"] as? String
        self.flight = flight
    }
    
    func toAny() -> Any? {
        return [
            "date" : date!,
            "boardingStartTime" : boardingStartTime!,
            "boardingEndTime" : boardingEndTime!,
            "price" : price!,
            "flight" : flight!.key!
        ]
    }
    
}
