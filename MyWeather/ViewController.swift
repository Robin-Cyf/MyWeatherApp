//
//  ViewController.swift
//  MyWeather
//
//  Created by Robin on 23/7/21.
//

import UIKit

//Location CoreLocation

//table view
//custom cell: collection view
//API /request to get the data

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table:UITableView!
    
    //creat array for model
    var models = [Weather]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //set table.delegate and table.dataSource
        table.delegate = self
        table.dataSource = self
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
