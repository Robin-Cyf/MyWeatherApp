//
//  ViewController.swift
//  MyWeather
//
//  Created by Robin on 23/7/21.
//

import UIKit
import CoreLocation


//Location CoreLocation

//table view
//custom cell: collection view
//API /request to get the data

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet var table:UITableView!
    //creat array for model
    var models = [Weather]()
    let locationMananger = CLLocationManager()
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        //The order of register cells is irrelavant as long as the cell register before it is used.
        super.viewDidLoad()
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        
        
        //set table.delegate and table.dataSource
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    //Location
    func setupLocation() {
        locationMananger.delegate = self
        locationMananger.requestWhenInUseAuthorization()
        locationMananger.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationMananger.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    //print out long and lant for location
    func requestWeatherForLocation() {
        //Use guard to make sure it is not nil when we using this let and no need for ? in the last step
        guard let currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        
        print ("\(long)  | (\(lat )")
        
        
    }

    
    
    
    
    
    // Tables function
    //register 2 custom cells
    //handlling collection view for horizional cells and normal vertical cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

struct Weather{
    
}
