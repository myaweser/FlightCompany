//
//  RegistrationTableViewController.swift
//  FlightCompany
//
//  Created by Michele Basile on 01/12/16.
//  Copyright © 2016 Deadliners. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    
    
    // MARK: - Action
    
    @IBAction func cancelDidPress(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneDidPress(_ sender: UIBarButtonItem) {
        
    }
    
    
    // MARK: - Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
