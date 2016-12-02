//
//  Passengers.swift
//  FlightCompany
//
//  Created by Michele Basile on 27/11/16.
//  Copyright © 2016 Deadliners. All rights reserved.
//

import Foundation
import Firebase


class Passengers {
    
    // Singleton
    static let shared = Passengers()
    private init() {}
    
    // Reference in JSON tree
    let databaseRef: FIRDatabaseReference = FIRDatabase.database().reference(withPath: "passengers")

    
    func create(passenger: Passenger, completion: ((Passenger?, Error?) -> Void)? = nil) {
        if let email = passenger.email, let password = passenger.password {
            FIRAuth.auth()?.createUser(withEmail: email, password: password) {
                user, error in
                if error == nil {
                    passenger.id = user?.uid
                    self.store(passenger: passenger)
                    completion?(passenger, nil)
                } else {
                    completion?(nil, error!)
                }
            }
        }
    }
    
    private func store(passenger: Passenger) {
        if let passengerId = passenger.id {
            databaseRef
                .child(passengerId)
                .setValue(["email" : passenger.email ?? "",
                           "name" : passenger.name ?? "",
                           "surname" : passenger.surname ?? ""])
        }
    }
    
}
