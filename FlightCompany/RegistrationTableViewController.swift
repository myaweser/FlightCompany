//
//  RegistrationTableViewController.swift
//  FlightCompany
//
//  Created by Michele Basile on 01/12/16.
//  Copyright © 2016 Deadliners. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController {
    
    let passengers = Passengers.shared

    // MARK: - Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    
    
    // MARK: - Action
    
    @IBAction func cancelDidPress(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneDidPress(_ sender: UIBarButtonItem) {
        if let email = emailTextField.text,
            let password = passwordTextField.text,
            let name = nameTextField.text,
            let surname = surnameTextField.text
        {
            let p = Passenger(email: email, password: password, name: name, surname: surname)
            passengers.create(passenger: p)
            performSegue(withIdentifier: "RegistrationToTabBar", sender: nil)
        }
    }
    
    
    // MARK: - Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
