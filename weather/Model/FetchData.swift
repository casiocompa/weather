//
//  FetchData.swift
//  weather
//
//  Created by Ruslan Kasian on 7/6/19.
//  Copyright © 2019 Ruslan Kasian. All rights reserved.
//

import Foundation
import CoreData
import Groot
import CoreLocation


class FetchData: NSObject {
    
    struct DefaultLocation {
        let city: String
        let country: String
        let lat: Double
        let long: Double
        init (city: String, country: String, lat: Double, long: Double){
            self.city = city
            self.country = country
            self.lat = lat
            self.long = long
        }
    }
    
    let weatherConditionsCode: Dictionary<Int,String> = [
        0 : "tornado",
        1 : "tropical storm",
        2 : "hurricane",
        3 : "severe thunderstorms",
        4 : "thunderstorms",
        5 : "mixed rain and snow",
        6 : "mixed rain and sleet",
        7 : "mixed snow and sleet",
        8 : "freezing drizzle",
        9 : "drizzle",
        10 : "freezing rain",
        11 : "showers",
        12 : "rain",
        13 : "snow flurries",
        14 : "light snow showers",
        15 : "blowing snow",
        16 : "snow",
        17 : "hail",
        18 : "sleet",
        19 : "dust",
        20 : "foggy",
        21 : "haze",
        22 : "smoky",
        23 : "blustery",
        24 : "windy",
        25 : "cold",
        26 : "cloudy",
        27 : "mostly cloudy (night)",
        28 : "mostly cloudy (day)",
        29 : "partly cloudy (night)",
        30 : "partly cloudy (day)",
        31 : "clear (night)",
        32 : "sunny",
        33 : "fair (night)",
        34 : "fair (day)",
        35 : "mixed rain and hail",
        36 : "hot",
        37 : "isolated thunderstorms",
        38 : "scattered thunderstorms",
        39 : "scattered showers (day)",
        40 : "heavy rain",
        41 : "scattered snow showers (day)",
        42 : "heavy snow",
        43 : "blizzard",
        44 : "not available",
        45 : "scattered showers (night)",
        46 : "scattered snow showers (night)",
        47 : "scattered thundershowers"]

    
    
    
    var managedObjectContext: NSManagedObjectContext? {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
    
    func fetchCityForecastFromApiToCoreDate (location: String,_ completion: @escaping (Bool)->Void){
        
        YahooWeatherAPI.shared.weather(location: location, failure: {
            (error) in
            print(error.localizedDescription)
        }, success: { (response) in
            DispatchQueue.main.async {
                do {
                    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
                    if let dataJSON: Data = response.string?.data(using: .utf8)  {
                        let citiesWeatherData: [CityWeathers] = try objects (fromJSONData: dataJSON, inContext: context)
                        citiesWeatherData[0].lastUpdate = Date()
//                        print (json(fromObjects: citiesWeatherData))
                        CoreDataStack.sharedInstance.saveContext()
                    } else {return}
                    print ("add new city")
                    completion(true)
                } catch {
                    completion(false)
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    func fetchCityForecastFromApiToCoreDate (lat:String, lon:String,_ completion: @escaping (Bool)->Void){
        YahooWeatherAPI.shared.weather(lat: lat, lon:lon, failure: { (error) in
            print(error.localizedDescription)
        }, success: { (response) in
            DispatchQueue.main.async {
                print (" fetch data API: \(Date())")
                do {
                    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
                    if let dataJSON: Data = response.string?.data(using: .utf8)  {
                        let citiesWeatherData: [CityWeathers] = try objects (fromJSONData: dataJSON, inContext: context)
                        citiesWeatherData[0].lastUpdate = Date()
                        CoreDataStack.sharedInstance.saveContext()
                    } else {return}
                    completion(true)
                } catch {
                    completion(false)
                    print ("ERROR")
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    func fetchCityForecastFromApiToCoreDate (for currentLocation: CLLocationCoordinate2D,_ completion: @escaping (Bool)->Void){
        YahooWeatherAPI.shared.weather(lat: currentLocation.latitude.description,
                                       lon:currentLocation.longitude.description,
                                       failure: { (error) in
            print(error.localizedDescription)
        }, success: { (response) in
            DispatchQueue.main.async {
                do {
                    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
                    if let dataJSON: Data = response.string?.data(using: .utf8)  {
                        let citiesWeatherData: [CityWeathers] = try objects (fromJSONData: dataJSON, inContext: context)
                        citiesWeatherData[0].currentLocation = true
                        citiesWeatherData[0].noDelete = true
                        citiesWeatherData[0].lastUpdate = Date()
//                        print (json(fromObjects: citiesWeatherData))
                        CoreDataStack.sharedInstance.saveContext()
                    } else {return}
                    completion(true)
                } catch {
                    completion(false)
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    
    
    func fetchAllCitiesForecastFromApiToCoreDate (_ completion: @escaping (Bool)->Void){
        var array = [CityWeathers]()
        fetchCitiesWeatherForecastFromCoreData { (cities) in
            if let cities = cities {
                array = cities
            }
        }
        
        
        YahooWeatherAPI.shared.weathers(locationArray: array, failure: { (error) in
            print(error.localizedDescription)
        }, success: { (response) in
            DispatchQueue.main.async {
                print ("all data update: \(Date())")
                do {
                    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
                    if let dataJSON: Data = response.string?.data(using: .utf8)  {
                        let citiesWeatherData: [CityWeathers] = try objects (fromJSONData: dataJSON, inContext: context)
                        citiesWeatherData[0].lastUpdate = Date()
//                        print (json(fromObjects: citiesWeatherData))
                        CoreDataStack.sharedInstance.saveContext()
                    }
                    else{
                        return
                    }
                    print ("all data updated: \(Date())")
                } catch {
                    print(error.localizedDescription)
                }
            }
        })
        
        
    }
    
    func firstStart (_ completion: @escaping (Bool)->Void) {
         let startCities: [DefaultLocation] = [
//            DefaultLocation(city: "current Location", country: "", lat: 0, long: 0),
            DefaultLocation(city: "kyiv", country: "ua", lat: 50.44138, long: 30.52249),
            DefaultLocation(city: "odessa", country: "ua", lat: 46.469479, long: 30.74003)
        ]
        print ("first srart: \(Date())")
        YahooWeatherAPI.shared.weathers(locationArray: startCities, failure: { (error) in
            print(error.localizedDescription)
        }, success: { (response) in
            DispatchQueue.main.async {
                do {
                    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
                    if let dataJSON: Data = response.string?.data(using: .utf8)  {
                        let citiesWeatherData: [CityWeathers] = try objects (fromJSONData: dataJSON, inContext: context)
                        citiesWeatherData[0].lastUpdate = Date()
                        citiesWeatherData[0].noDelete = true
                        CoreDataStack.sharedInstance.saveContext()
                    }
                    else{
                        return                        
                    }
                     UserDefaults.standard.set(true, forKey: "firstStart")
                    completion(true)
                    print ("first srart is OK: \(Date())")
                } catch {
                    completion(false)
                    print(error.localizedDescription)
                }
            }
        })
    
    
    }
    
    func fetchCitiesWeatherForecastFromCoreData(completion: ([CityWeathers]?)->Void){
        var results = [CityWeathers]()
        let request: NSFetchRequest<CityWeathers> = CityWeathers.fetchRequest()
        do {
            results = try  managedObjectContext!.fetch(request)
            completion(results)
        }catch {
            print("Could not fetch Products from CoreData:\(error.localizedDescription)")
        }
    }
    
}
    
    
    

