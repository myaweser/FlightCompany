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
    
    func getPassenger(withEmail email: String) -> Passenger? {
        var passenger: Passenger?
        databaseRef
            .queryOrdered(byChild: "email")
            .queryEqual(toValue: email)
            .observeSingleEvent(of: .value, with: { snapshot in
                for child in snapshot.children {
                    let passengerSnapshot = child as! FIRDataSnapshot
                    let passengerValue = passengerSnapshot.value as! [String : AnyObject]
                    passenger = Passenger(id: passengerSnapshot.key,
                                          email: passengerValue["email"] as? String,
                                          password: nil,
                                          name: passengerValue["name"] as? String,
                                          surname: passengerValue["surname"] as? String)
                    print("Get the passenger with email: \(email)")
                }
            })
        return passenger
    }
    
    func create(passenger: Passenger) {
        if let email = passenger.email, let password = passenger.password {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    self.store(passenger: passenger)
                } else {
                    print("Creation error: \(error!.localizedDescription)")
                }
            })
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
