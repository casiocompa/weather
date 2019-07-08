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
    
    
    

