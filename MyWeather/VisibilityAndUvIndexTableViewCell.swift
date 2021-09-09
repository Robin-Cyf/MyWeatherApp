//
//  VisibilityAndUvIndexTableViewCell.swift
//  MyWeather
//
//  Created by Robin on 24/8/21.
//

import UIKit

class VisibilityAndUvIndexTableViewCell: UITableViewCell {

    @IBOutlet var visibilityLabel: UILabel!
    @IBOutlet var uvIndexLabel: UILabel!
    @IBOutlet var visibility: UILabel!
    @IBOutlet var uvIndex: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    func configure() {
        
        visibilityLabel.text = "VISIBILITY"
        visibilityLabel.font = UIFont(name: "Helvetica Neue UltraLight ", size: 5)
        visibilityLabel.textColor = UIColor.white
        
        uvIndexLabel.text = "UV INDEX"
        uvIndexLabel.font = UIFont(name: "Helvetica Neue UltraLight ", size: 5)
        uvIndexLabel.textColor = UIColor.white

        visibility.text = "12.9 km"
        visibility.font = UIFont(name: "Helvetica Neue", size: 30)
        visibility.textColor = UIColor.white
        
        uvIndex.text = "1"
        uvIndex.font = UIFont(name: "Helvetica Neue", size: 30)
        uvIndex.textColor = UIColor.white

        }


}
