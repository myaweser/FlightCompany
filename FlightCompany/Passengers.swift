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
    
    static let shared = Passengers()
    let databaseRef: FIRDatabaseReference = FIRDatabase.database().reference(withPath: "passengers")
    private init() {}
    
    func create(passenger: Passenger) -> Passenger {
        let newPassenger = Passenger(from: passenger)
        if let email = passenger.email, let password = passenger.password {
            FIRAuth.auth()!.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    newPassenger.id = user?.uid
                    self.store(passenger: newPassenger)
                } else {
                    print("Creation error: \(error!.localizedDescription)")
                }
            })
        }
        return newPassenger
    }
    
    private func store(passenger: Passenger) {
        if let passengerId = passenger.id {
            databaseRef.child(passengerId).setValue(["email" : passenger.email ?? "",
                                                     "name" : passenger.name ?? "",
                                                     "surname" : passenger.surname ?? ""])
        }
    }
}
