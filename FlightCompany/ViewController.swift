//
//  ViewController.swift
//  FlightCompany
//
//  Created by Michele Basile on 27/11/16.
//  Copyright © 2016 Deadliners. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PassengersDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        Passengers.shared.delegate = self
        Passengers.shared.getPassenger(withEmail: "mich.basile@gmail.com")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didGet(_ passenger: Passenger) {
        print("Get the passenger with email \(passenger.email!)")
    }
    
    func didCreate(_ passenger: Passenger) {
        
    }


}

