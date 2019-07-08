//
//  CityWeathers+CoreDataProperties.swift
//  weather
//
//  Created by Ruslan Kasian on 7/8/19.
//  Copyright © 2019 Ruslan Kasian. All rights reserved.
//
//

import Foundation
import CoreData


extension CityWeathers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityWeathers> {
        return NSFetchRequest<CityWeathers>(entityName: "CityWeathers")
    }

    @NSManaged public var chill: Double
    @NSManaged public var city: String?
    @NSManaged public var code: Int
    @NSManaged public var country: String?
    @NSManaged public var direction: Double
    @NSManaged public var humidity: Double
    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var pressure: Double
    @NSManaged public var pubDate: Int
    @NSManaged public var region: String?
    @NSManaged public var speed: Double
    @NSManaged public var sunrise: String?
    @NSManaged public var sunset: String?
    @NSManaged public var temperature: Int
    @NSManaged public var text: String?
    @NSManaged public var timezoneID: String?
    @NSManaged public var visibility: Double
    @NSManaged public var woeid: Int
    @NSManaged public var noDelete: Bool
    @NSManaged public var currentLocation: Bool
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var forecasts: Set<Forecast>

}

// MARK: Generated accessors for forecasts
extension CityWeathers {

    @objc(addForecastsObject:)
    @NSManaged public func addToForecasts(_ value: Forecast)

    @objc(removeForecastsObject:)
    @NSManaged public func removeFromForecasts(_ value: Forecast)

    @objc(addForecasts:)
    @NSManaged public func addToForecasts(_ values: NSSet)

    @objc(removeForecasts:)
    @NSManaged public func removeFromForecasts(_ values: NSSet)

}
