//
//  CitiesWeathersTableViewController.swift
//  weather
//
//  Created by Ruslan Kasian on 7/4/19.
//  Copyright © 2019 Ruslan Kasian. All rights reserved.
//

import UIKit
import CoreData
import Groot

class CitiesWeathersTableViewController: UITableViewController, NSFetchedResultsControllerDelegate{
    
    var managedObjectContext: NSManagedObjectContext? {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
    
    
    var citiesWeatherForecast = [CityWeathers](){
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        retrieveCitiesWeatherForecast()
        
        
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
        fetchCitiesForecastFromApiToCoreDate()
   
    }
    
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        // Do your job, when done:
        fetchCitiesForecastFromApiToCoreDate()
                refreshControl.endRefreshing()
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return citiesWeatherForecast.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityForecastCell", for: indexPath) as! CityForecastTableViewCell
        cell.cityForecast =  citiesWeatherForecast[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99
    }
    
    
    func retrieveCitiesWeatherForecast(){
        FetchData().fetchCitiesWeatherForecastFromCoreData { (cities) in
            if let cities = cities {
                self.citiesWeatherForecast = cities
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCityForecastDatail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = citiesWeatherForecast[indexPath.row]
                //                let object = fetchedResultsController.object(at: indexPath)
                let controller = (segue.destination as! UITableViewController) as! CityWeatherTableViewController
                controller.cityWeatherForecasts = object
                controller.cityForecasts = Array(object.forecasts.sorted(by: { $0.date < $1.date }))
            }
        }
    }
    
    func fetchCitiesForecastFromApiToCoreDate (){
        FetchData().fetchAllCitiesForecastFromApiToCoreDate() { (result) in
            if result {
                self.tableView.refreshControl?.endRefreshing()
                self.retrieveCitiesWeatherForecast()
            } else {
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        fetchCitiesForecastFromApiToCoreDate ()
    }
    
}
