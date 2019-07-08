//
//  CityWeatherTableViewController.swift
//  weather
//
//  Created by Ruslan Kasian on 7/4/19.
//  Copyright © 2019 Ruslan Kasian. All rights reserved.
//

import UIKit
import CoreData


class CityWeatherTableViewController: UITableViewController {

    @IBOutlet weak var cityNameLableOutlet: UINavigationItem!
    
//    var citiesWeatherForecast = [CityWeathers]()
    
    var cityWeatherForecasts: CityWeathers? {
        didSet {
            tableView.reloadData()
        }
    }

    var cityForecasts: Array<Forecast> = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
            tableView.refreshControl?.attributedTitle = NSAttributedString (string: "Fetching weather forecast data ...")
            self.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            tableView.backgroundView = refreshControl
        }
        
        tableView.tableFooterView = UIView(frame: .zero)


        if let city = cityWeatherForecasts?.city , let country = cityWeatherForecasts?.country {
             cityNameLableOutlet.title = "\(city.description), \(country.description)"
        }
        
        
        
    }

    @objc func refresh(_ refreshControl: UIRefreshControl) {
        // Do your job, when done:
//        fetchCityForecastFromApiToCoreDate()
                refreshControl.endRefreshing()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if section == 0 {
        return 1
       }
       else{
        return cityForecasts.count
        
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "todayForecastCell", for: indexPath) as! TodayForecastTableViewCell
            
            cell.todayForecast = cityWeatherForecasts
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "dailyForecastCell", for: indexPath) as! DailyForecastTableViewCell
            cell.dailyForecast = cityForecasts[indexPath.row]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
        return 180
        } else {
        return 69
        }
    }
    
    func fetchCitiesForecastFromApiToCoreDate (){
        FetchData().fetchAllCitiesForecastFromApiToCoreDate() { (result) in
            if result {
                self.tableView.refreshControl?.endRefreshing()
//                self.retrieveCitiesWeatherForecast()
            } else {
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }
}
