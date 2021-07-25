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
    var models = [DailyWeatherEntry]()
    let locationMananger = CLLocationManager()
    var currentLocation: CLLocation?
    var current:CurrentWeather?
    
    override func viewDidLoad() {
        //The order of register cells is irrelavant as long as the cell register before it is used.
        super.viewDidLoad()
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        
        //set table.delegate and table.dataSource
        table.delegate = self
        table.dataSource = self
        
        //set up the table and view color as same as the background color
        table.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
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
        
        //API request the weather data from the Dark Api
        let url = "https://api.darksky.net/forecast/ddcc4ebb2a7c9930b90d9e59bda0ba7a/\(lat),\(long)?exclude=[flags,minutely]"
        //URLsession
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            //Do Validation - make sure data back and no wrong
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            //convert data to models/some object
        var json: WeatherResponse?
            do {
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
            }
            catch{
                print("error:\(error)")
            }
            guard let result = json else {
                 return
            }
            let entries = result.daily.data
            self.models.append(contentsOf: entries)
            //Assign the current weather to the property
            let current = result.currently
            self.current = current
            //update user interface
            DispatchQueue.main.async {
                //telling the program the following code going to the main theard
                self.table.reloadData()
                self.table.tableHeaderView = self.createTableHeader()
                
            }
        }).resume()
    }
    
    func createTableHeader() ->UIView {
        
        let headerVIew = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        //set up background color
        headerVIew.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        
        

        //3 labels on the table
        let locationLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width-20, height: headerVIew.frame.size.height/5))
        let summaryLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height, width: view.frame.size.width-20, height: headerVIew.frame.size.height/5))
        let tempLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height+summaryLabel.frame.size.height, width: view.frame.size.width-20, height: headerVIew.frame.size.height/2))

        headerVIew.addSubview(locationLabel)
        headerVIew.addSubview(tempLabel)
        headerVIew.addSubview(summaryLabel)
        
        tempLabel.textAlignment = .center
        locationLabel.textAlignment = .center
        summaryLabel.textAlignment = .center

        locationLabel.text = "Current Location"
        
        guard let currentWeather = self.current else {
            return UIView()
        }
        tempLabel.text = "\(currentWeather.temperature)°"
        tempLabel.font = UIFont(name: "Helvetica-Bold", size: 32)
        summaryLabel.text = self.current?.summary

        return headerVIew
        
    }
    // Tables function
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    //register 2 custom cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // 1 cell that is collectiontableviewcell
            return 1
        }
        // return models count
        return models.count
    }
    //handlling collection view for horizional cells and normal vertical cells
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
    //call the configure func from the WeatherTableViewCell
        cell.configure(with: models[indexPath.row])
        //setup background on the cell
        cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

struct WeatherResponse: Codable {
    let latitude: Float
    let longitude: Float
    let timezone: String
    let currently: CurrentWeather
    let hourly: HourlyWeather
    let daily: DailyWeather
    let offset: Float
}

struct CurrentWeather: Codable {
    let time: Int
    let summary: String
    let icon: String
    let nearestStormDistance: Int
    let nearestStormBearing: Int
    let precipIntensity: Int
    let precipProbability: Int
    let temperature: Double
    let apparentTemperature: Double
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windBearing: Int
    let cloudCover: Double
    let uvIndex: Int
    let visibility: Double
    let ozone: Double
}

struct DailyWeather: Codable {
    let summary: String
    let icon: String
    let data: [DailyWeatherEntry]
}

struct DailyWeatherEntry: Codable {
    let time: Int
    let summary: String
    let icon: String
    let sunriseTime: Int
    let sunsetTime: Int
    let moonPhase: Double
    let precipIntensity: Float
    let precipIntensityMax: Float
    let precipIntensityMaxTime: Int
    let precipProbability: Double
    let precipType: String?
    let temperatureHigh: Double
    let temperatureHighTime: Int
    let temperatureLow: Double
    let temperatureLowTime: Int
    let apparentTemperatureHigh: Double
    let apparentTemperatureHighTime: Int
    let apparentTemperatureLow: Double
    let apparentTemperatureLowTime: Int
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windGustTime: Int
    let windBearing: Int
    let cloudCover: Double
    let uvIndex: Int
    let uvIndexTime: Int
    let visibility: Double
    let ozone: Double
    let temperatureMin: Double
    let temperatureMinTime: Int
    let temperatureMax: Double
    let temperatureMaxTime: Int
    let apparentTemperatureMin: Double
    let apparentTemperatureMinTime: Int
    let apparentTemperatureMax: Double
    let apparentTemperatureMaxTime: Int
}

struct HourlyWeather: Codable {
    let summary: String
    let icon: String
    let data: [HourlyWeatherEntry]
}

struct HourlyWeatherEntry: Codable {
    let time: Int
    let summary: String
    let icon: String
    let precipIntensity: Float
    let precipProbability: Double
    let precipType: String?
    let temperature: Double
    let apparentTemperature: Double
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windBearing: Int
    let cloudCover: Double
    let uvIndex: Int
    let visibility: Double
    let ozone: Double
}
