//
//  File.swift
//  weather
//
//  Created by Ruslan Kasian on 7/4/19.
//  Copyright © 2019 Ruslan Kasian. All rights reserved.
//

import UIKit
import CoreLocation

class LocationService: NSObject {
    
    var newestLocation: ((CLLocationCoordinate2D?) -> Void)?
    var statusUpdated: ((CLAuthorizationStatus) -> Void)?
    let manager: CLLocationManager
    
    var status: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
        super.init()
        manager.delegate = self
    }
    
    func getPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func getLocation() {
        manager.requestLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.sorted(by: { $0.timestamp > $1.timestamp }).first {
            self.newestLocation?(location.coordinate)
        } else {
            self.newestLocation?(nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get the user loction: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Location status: \(status)")
        self.statusUpdated?(status)
    }
    
}

