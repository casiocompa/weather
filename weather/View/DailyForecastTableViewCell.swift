//
//  DailyForecastTableViewCell.swift
//  weather
//
//  Created by Ruslan Kasian on 7/4/19.
//  Copyright © 2019 Ruslan Kasian. All rights reserved.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dayOfTheWeekLableOutlet: UILabel!
    @IBOutlet weak var dateLableOutlet: UILabel!
    @IBOutlet weak var temperatureLabelOutlet: UILabel!
    @IBOutlet weak var forecastImageViewOutlet: UIImageView!
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter
    }()
    
    lazy var dateFormatterDayOfWeek: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }()
    
    func dateisToDay(toDate: Date) -> Bool {
        
        let components = Calendar.current.dateComponents([.day], from: Date(), to: toDate)
        print (components.day )
        if components.day == 0 {
            return true
        }
        return false
    }
    
    var dailyForecast: Forecast? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = dailyForecast,
            let dayOfTheWeekLable = dayOfTheWeekLableOutlet,
            let dateLable = dateLableOutlet,
            let temperatureLabel = temperatureLabelOutlet,
            let forecastImageView = forecastImageViewOutlet {
            let dateInt =  Date(timeIntervalSince1970: TimeInterval(detail.date))
            
            if dateisToDay(toDate: dateInt) {
                dayOfTheWeekLable.text = "Today"
            }else{
                dayOfTheWeekLable.text = dateFormatterDayOfWeek.string(from: dateInt)
            }
            dateLable.text = dateFormatter.string(from: dateInt)
            temperatureLabel.text =  "\(detail.high.description) — \(detail.low.description) ºC"
            forecastImageView.image = UIImage(named: "rain")
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
