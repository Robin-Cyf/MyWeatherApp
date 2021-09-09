//
//  WindandFeelsLikeTableViewCell.swift
//  MyWeather
//
//  Created by Robin on 24/8/21.
//

import UIKit

class WindandFeelsLikeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet var windLabel: UILabel!
    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var windSpeed: UILabel!
    @IBOutlet var feelsLikeTemp: UILabel!
    

    
    func configure() {
        
        windLabel.text = "WIND"
        windLabel.font = UIFont(name: "Helvetica Neue UltraLight ", size: 5)
        windLabel.textColor = UIColor.white
        
        feelsLikeLabel.text = "FEELS LIKE"
        feelsLikeLabel.font = UIFont(name: "Helvetica Neue UltraLight ", size: 5)
        feelsLikeLabel.textColor = UIColor.white
        
        windSpeed.text = "S 16km/h"
        windSpeed.font = UIFont(name: "Helvetica Neue", size: 30)
        windSpeed.textColor = UIColor.white
        
        feelsLikeTemp.text = "12°"
        feelsLikeTemp.font = UIFont(name: "Helvetica Neue", size: 30)
        feelsLikeTemp.textColor = UIColor.white

        }


}
