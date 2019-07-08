//
//  Weather.swift
//  weather
//
//  Created by Ruslan Kasian on 7/2/19.
//  Copyright © 2019 Ruslan Kasian. All rights reserved.
//

import Foundation

//struct CityWeatherStruct {
//    let notDeleted: Bool?
//    let forecasts: [ForecastStr]
//    let pubDate: Int
//    //    let dayOfTheWeek: String
//
//    // Location
//    let woeid: Int
//    let city: String
//    let region: String
//    let country: String
//    let lat: Double
//    let long: Double
//    let timezoneID: String
//
//    //Current observation
//    //Wind
//    let chill: Double
//    let direction: Double
//    let speed: Double
//
//    //Atmosphere
//    let humidity: Double
//    let visibility: Double
//    let pressure: Double
//
//    //Astronomy
//    let sunrise: String
//    let sunset: String
//
//    //Condition
//    let text: String
//    let code: Double
//    let temperature: Double
//
//
//
//    init (_ structJson: WeatherStruct, notDeleted: Bool = false) {
//        self.notDeleted = notDeleted
//        self.pubDate = structJson.currentObservation.pubDate
//        self.forecasts = structJson.forecasts
//
//        // Location
//        self.woeid = structJson.location.woeid
//        self.city = structJson.location.city
//        self.region = structJson.location.region
//        self.country = structJson.location.country
//        self.lat = structJson.location.lat
//        self.long = structJson.location.long
//        self.timezoneID = structJson.location.timezoneID
//
//        //Current observation
//        //Wind
//        self.chill = structJson.currentObservation.wind.chill
//        self.direction = structJson.currentObservation.wind.direction
//        self.speed = structJson.currentObservation.wind.speed
//
//        //Atmosphere
//        self.humidity = structJson.currentObservation.atmosphere.humidity
//        self.visibility = structJson.currentObservation.atmosphere.visibility
//        self.pressure = structJson.currentObservation.atmosphere.pressure
//
//        //Astronomy
//        self.sunrise = structJson.currentObservation.astronomy.sunrise
//        self.sunset = structJson.currentObservation.astronomy.sunset
//
//        //Condition
//        self.text = structJson.currentObservation.condition.text
//        self.code = structJson.currentObservation.condition.code
//        self.temperature = structJson.currentObservation.condition.temperature
//    }
//
//    //    let format: ((_ dateInt: Int) -> String) = { (count) in
//    //        let date =  Date(timeIntervalSince1970: TimeInterval(count))
//    //        let formatter = DateFormatter()
//    //        formatter.dateFormat = "EEEE"
//    //        return formatter.string(from: date)
//    //    }
//}
//

//// MARK: - Weather
//struct WeatherStruct: Codable {
//    let location: LocationStr
//    let currentObservation: CurrentObservationStr
//    let forecasts: [ForecastStr]
//    
//    enum CodingKeys: String, CodingKey {
//        case location
//        case currentObservation = "current_observation"
//        case forecasts
//    }
//}
//
//extension WeatherStruct {
//    init(data: Data) throws {
//        self = try newJSONDecoder().decode(WeatherStruct.self, from: data)
//    }
//    
//    init(_ json: String?, using encoding: String.Encoding = .utf8) throws {
//        guard let data = json?.data(using: encoding) else {
//            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
//        }
//        try self.init(data: data)
//    }
//    
//    init(fromURL url: URL) throws {
//        try self.init(data: try Data(contentsOf: url))
//    }
//}
//
//// MARK: - CurrentObservation
//struct CurrentObservationStr: Codable {
//    let wind: WindStr
//    let atmosphere: AtmosphereStr
//    let astronomy: AstronomyStr
//    let condition: ConditionStr
//    let pubDate: Int
//}
//
//// MARK: - Astronomy
//struct AstronomyStr: Codable {
//    let sunrise: String
//    let sunset: String
//}
//
//// MARK: - Atmosphere
//struct AtmosphereStr: Codable {
//    let humidity: Double
//    let visibility: Double
//    let pressure: Double
//}
//
//// MARK: - Condition
//struct ConditionStr: Codable {
//    let text: String
//    let code: Double
//    let temperature: Double
//}
//
//// MARK: - Wind
//struct WindStr: Codable {
//    let chill: Double
//    let direction: Double
//    let speed: Double
//}
//
//// MARK: - Forecast
//struct ForecastStr: Codable {
//    let code: Int
//    let date: Int
//    let day: String
//    let high: Int
//    let low: Int
//    let text: String
//    
//}
//
//// MARK: - Location
//struct LocationStr: Codable {
//    let woeid: Int
//    let city: String
//    let region: String
//    let country: String
//    let lat: Double
//    let long: Double
//    let timezoneID: String
//    
//    enum CodingKeys: String, CodingKey {
//        case woeid
//        case city
//        case region
//        case country
//        case lat
//        case long
//        case timezoneID = "timezone_id"
//    }
//}
//
//
//
//func newJSONDecoder() -> JSONDecoder {
//    let decoder = JSONDecoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        decoder.dateDecodingStrategy = .iso8601
//    }
//    return decoder
//}
//
//func newJSONEncoder() -> JSONEncoder {
//    let encoder = JSONEncoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        encoder.dateEncodingStrategy = .iso8601
//    }
//    return encoder
//}

//typealias CitiesWeatherForecast = [CityWeatherStruct]

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

