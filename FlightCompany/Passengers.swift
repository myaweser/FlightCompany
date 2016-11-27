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
    var delegate: PassengersDelegate?
    private init() {}
    
    func getPassenger(withEmail email: String) {
        if delegate != nil {
            databaseRef
                .queryOrdered(byChild: "email")
                .queryEqual(toValue: email)
                .observeSingleEvent(of: .value, with: { snapshot in
                    for child in snapshot.children {
                        let passengerSnapshot = child as! FIRDataSnapshot
                        let passengerValue = passengerSnapshot.value as! [String : AnyObject]
                        let passenger = Passenger(id: passengerSnapshot.key,
                                                  email: passengerValue["email"] as? String,
                                                  password: nil,
                                                  name: passengerValue["name"] as? String,
                                                  surname: passengerValue["surname"] as? String)
                        self.delegate!.didGet(passenger)
                    }
                })
        }
    }
    
    func create(passenger: Passenger) {
        if let email = passenger.email, let password = passenger.password {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    passenger.id = user?.uid
                    self.store(passenger: passenger)
                    self.delegate?.didCreate(passenger)
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

protocol PassengersDelegate {
    func didGet(_ passenger: Passenger)
    func didCreate(_ passenger: Passenger)
}
