//
//  CityForecastTableViewCell.swift
//  weather
//
//  Created by Ruslan Kasian on 7/4/19.
//  Copyright © 2019 Ruslan Kasian. All rights reserved.
//

import UIKit

class CityForecastTableViewCell: UITableViewCell {

   
    @IBOutlet weak var cityLableOutlet: UILabel!
    
    @IBOutlet weak var temperatureLabelOutlet: UILabel!
    
    @IBOutlet weak var forecastImageViewOutlet: UIImageView!
    
    var cityForecast: CityWeathers? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = cityForecast,
            let cityLable = cityLableOutlet,
            let  temperatureLabel = temperatureLabelOutlet,
            let forecastImageView = forecastImageViewOutlet {
            cityLable.text = detail.city?.description
            temperatureLabel.text = "\(detail.temperature.description) ºC"
            forecastImageView.image = UIImage(named: "clear-day")
        
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
