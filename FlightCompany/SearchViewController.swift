//
//  SearchViewController.swift
//  FlightCompany
//
//  Created by Michele Basile on 01/12/16.
//  Copyright © 2016 Deadliners. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var airportsList: [Airport] = []

    // MARK: - Outlets
    
    @IBOutlet weak var departureAirportPicker: UIPickerView!
    @IBOutlet weak var arrivalAirportPicker: UIPickerView!
    @IBOutlet weak var dateFromPicker: UIDatePicker!
   
    
    // MARK: - PickerViews
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // We are going to show only airport locality
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return airportsList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return airportsList[row].locality
    }
    
    
    // MARK: - Actions
    
    @IBAction func searchDidPress(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "Flight List", sender: nil)
    }
    
    
    // MARK: - Utils
    
    func getSearchParameters() -> (departure: Airport, arrival: Airport, date: String) {
        let departureAirport = airportsList[departureAirportPicker.selectedRow(inComponent: 0)]
        let arrivalAirport = airportsList[arrivalAirportPicker.selectedRow(inComponent: 0)]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let dateFrom =  dateFormatter.string(from: dateFromPicker.date)
        return (departureAirport, arrivalAirport, dateFrom)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Flight List" {
            if let flightListTVC = segue.destination as? FlightsTableViewController {
                
                // Retrieve search parameters from outlets
                let (departureAirport, arrivalAirport, dateFrom) = getSearchParameters()
                
                // Database querying
                SpecificFlights.shared.get(from: departureAirport, to: arrivalAirport, dateFrom: dateFrom, completion: { specificFlights in
                    // Injection into flight list controller
                    flightListTVC.flights = specificFlights
                })
            }
        }
    }
    
    
    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get all airport entries from firebase
        Airports.shared.getAll { airports in
            self.airportsList = airports
            self.departureAirportPicker.reloadAllComponents()
            self.arrivalAirportPicker.reloadAllComponents()
        }
        
        // Setting delegates and datasources
        departureAirportPicker.delegate = self
        departureAirportPicker.dataSource = self
        arrivalAirportPicker.delegate = self
        arrivalAirportPicker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
}
