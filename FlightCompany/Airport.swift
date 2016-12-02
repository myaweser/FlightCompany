//
//  Airport.swift
//  FlightCompany
//
//  Created by Michele Basile on 02/12/16.
//  Copyright © 2016 Deadliners. All rights reserved.
//

import Foundation
import Firebase

class Airport {

    var key: String?
    var code: String?
    var locality: String?
    
    init(code: String, locality: String) {
        self.code = code
        self.locality = locality
    }
    
    init(snapshot: FIRDataSnapshot) {
        self.key = snapshot.key
        let snapValue = snapshot.value as! [String : AnyObject]
        self.code = snapValue["code"] as? String
        self.locality = snapValue["locality"] as? String
    }
    
    func toAny() -> Any? {
        return [
            "code" : code!,
            "locality" : locality!
        ]
    }
    
}
