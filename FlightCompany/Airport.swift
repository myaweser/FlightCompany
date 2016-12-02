//
//  Airport.swift
//  FlightCompany
//
//  Created by Michele Basile on 02/12/16.
//  Copyright © 2016 Deadliners. All rights reserved.
//

import Foundation

class Airport {

    var key: String?
    var code: String?
    var locality: String?
    
    init(code: String, locality: String) {
        self.code = code
        self.locality = locality
    }
    
    func toAny() -> Any? {
        return [
            "code" : code!,
            "locality" : locality!
        ]
    }
    
}
