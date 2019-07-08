//
//  Forecast+CoreDataProperties.swift
//  weather
//
//  Created by Ruslan Kasian on 7/8/19.
//  Copyright © 2019 Ruslan Kasian. All rights reserved.
//
//

import Foundation
import CoreData


extension Forecast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Forecast> {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<Forecast>(entityName: "Forecast")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }

    @NSManaged public var code: Int
    @NSManaged public var date: Int
    @NSManaged public var day: String?
    @NSManaged public var high: Int
    @NSManaged public var low: Int
    @NSManaged public var text: String?
    @NSManaged public var currentCity: CityWeathers

}
