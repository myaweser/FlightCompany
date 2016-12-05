//
//  LoginViewController.swift
//  FlightCompany
//
//  Created by Michele Basile on 01/12/16.
//  Copyright © 2016 Deadliners. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK: - Actions
    
    @IBAction func signInDidPress(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { user, error in
                if error == nil {
                    print("User with id \(user!.uid) has just logged in")
                    self.performSegue(withIdentifier: "LoginToTabBar", sender: nil)
                } else {
                    print("There is an error: \(error!.localizedDescription)")
                }
            })
        }
    }
    
    
    // MARK: - Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        DatabaseDump.shared.populate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
