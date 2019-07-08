//
//  AppDelegate.swift
//  weather
//
//  Created by Ruslan Kasian on 7/1/19.
//  Copyright © 2019 Ruslan Kasian. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let locationService = LocationService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // load theme
//        if UserDefaults.standard.object(forKey: "CurrentTheme") != nil {
//            Theme.current = UserDefaults.standard.bool(forKey: "CurrentTheme") ? LightTheme(): DarkTheme()
//           
//        }
        if UserDefaults.standard.object(forKey: "firstStart") == nil {
            firstStart()
        }
        
        print ("location fetch start: \(Date())")
        // Location service callbacks
        locationService.newestLocation = { [weak self] coordinate in
            guard let coordinate = coordinate else { return }
            print("Location is: \(coordinate)")
            self?.getForecast(for: coordinate)
        }
        locationService.statusUpdated = { [weak self] status in
            if status == .authorizedWhenInUse {
                self?.locationService.getLocation()
            }
        }
        
        switch locationService.status {
        case .notDetermined:
            locationService.getPermission()
        case .authorizedWhenInUse:
            locationService.getLocation()
        default: assertionFailure("Location is: \(locationService.status)")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
         CoreDataStack.sharedInstance.saveContext()
    }

    func getForecast(for coordinates: CLLocationCoordinate2D) {
        // Forecast request
        FetchData().fetchCityForecastFromApiToCoreDate (for: coordinates) { (result) in
            if result {
                
                print("Weather for current location: \(coordinates) fetch")
                if let forecastViewController = AppDelegate.viewControllerInNav(ofType: CitiesWeathersTableViewController.self, in: self.window) {
                forecastViewController.retrieveCitiesWeatherForecast()
                }
            } else {
                print("Network request failed")
            }
        }
    }
    
    
    func firstStart (){
        FetchData().firstStart () { (result) in
            if result {
                if let forecastViewController = AppDelegate.viewControllerInNav(ofType: CitiesWeathersTableViewController.self, in: self.window) {
                    forecastViewController.retrieveCitiesWeatherForecast()
                }
            } else {
                print("Network request failed")
            }
        }
    
    
}
    static func viewControllerInNav<T>(ofType: T.Type, in window: UIWindow?) -> T? {
        return window?.rootViewController
            .flatMap { $0 as? UINavigationController }?
            .viewControllers
            .first(where: { $0 is T }) as? T
    }
    
}

