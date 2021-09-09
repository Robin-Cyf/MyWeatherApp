//
//  PrecipitationAndPressureTableViewCell.swift
//  MyWeather
//
//  Created by Robin on 24/8/21.
//

import UIKit

class PrecipitationAndPressureTableViewCell: UITableViewCell {

    @IBOutlet var precipitationLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var precipitation: UILabel!
    @IBOutlet var pressure: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    func configure() {
        
        precipitationLabel.text = "PRECIPITATION"
        precipitationLabel.font = UIFont(name: "Helvetica Neue UltraLight ", size: 5)
        precipitationLabel.textColor = UIColor.white
        
        pressureLabel.text = "PRESSURE"
        pressureLabel.font = UIFont(name: "Helvetica Neue UltraLight ", size: 5)
        pressureLabel.textColor = UIColor.white
        
        precipitation.text = "0.3 mm"
        precipitation.font = UIFont(name: "Helvetica Neue", size: 30)
        precipitation.textColor = UIColor.white
        
        pressure.text = "1025 hPa"
        pressure.font = UIFont(name: "Helvetica Neue", size: 30)
        pressure.textColor = UIColor.white
        }


}
