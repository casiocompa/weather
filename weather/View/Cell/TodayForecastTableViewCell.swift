//
//  TodayForecastTableViewCell.swift
//  weather
//
//  Created by Ruslan Kasian on 7/6/19.
//  Copyright © 2019 Ruslan Kasian. All rights reserved.
//

import UIKit

class TodayForecastTableViewCell: UITableViewCell {
    

    
    @IBOutlet weak var locationImageViewOutlet: UIImageView!
    @IBOutlet weak var cityNameLableOutlet: UILabel!
    @IBOutlet weak var countryNameLableOutlet: UILabel!
    @IBOutlet weak var currentConditionLableOutlet: UILabel!
    @IBOutlet weak var temperatureLabelOutlet: UILabel!
    @IBOutlet weak var forecastImageViewOutlet: UIImageView!
    
    
    
    
    var todayForecast: CityWeathers? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    
    func configureView() {
      
        if  let detail = todayForecast,
            let cityNameLable = cityNameLableOutlet,
            let countryNameLable = countryNameLableOutlet,
            let currentConditionLable = currentConditionLableOutlet,
            let temperatureLabel = temperatureLabelOutlet,
            let forecastImageView = forecastImageViewOutlet,
            let locationImageView = locationImageViewOutlet {
            if let city = detail.city ,
                let country = detail.country ,
                let condition = detail.text {
                
                cityNameLable.text = "\(city.description)"
                countryNameLable.text  = "\(country.description)"
                currentConditionLable.text = "\(condition)"
            }
            
            temperatureLabel.text = "\(detail.temperature) ºC"
            forecastImageView.image = UIImage(named: "clear-day")
            locationImageView.isHidden = !detail.currentLocation
            
            if let imageName = FetchData().weatherConditionsCode[detail.code] {
                forecastImageView.image = UIImage(named: imageName)
            }else {
                forecastImageView.image = UIImage(named: "not available")
            }
        }
        
    }
    
    let format: ((_ dateInt: Int) -> String) = { (count) in
        let date =  Date(timeIntervalSince1970: TimeInterval(count))
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"//"EEEE"
        return formatter.string(from: date)
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
