//
//  YahooWeatherAPI.swift
//  weather
//
//  Created by Ruslan Kasian on 7/1/19.
//  Copyright © 2019 Ruslan Kasian. All rights reserved.
//

import Foundation
import OAuthSwift

enum YahooWeatherAPIResponseType:String {
    case json = "json"
    case xml = "xml"
}

enum YahooWeatherAPIUnitType:String {
    case imperial = "f"
    case metric = "c"
}

fileprivate struct YahooWeatherAPIClientCredentials {
    var appId = ""
    var clientId = ""
    var clientSecret = ""
}

class YahooWeatherAPI {
    // Configure the following with your values.
    private let credentials = YahooWeatherAPIClientCredentials(
        appId: "colFil78",
        clientId: "dj0yJmk9VUp3N2FJZ3RsQTRRJmQ9WVdrOVkyOXNSbWxzTnpnbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmc3Y9MCZ4PTUz",
        clientSecret: "ebf374acbfad4e8b3035787346a57bf6501022fc"
    )
    
    private let url:String = "https://weather-ydn-yql.media.yahoo.com/forecastrss"
    private let oauth:OAuth1Swift?
    
    public static let shared = YahooWeatherAPI()
    
    private init() {
        self.oauth = OAuth1Swift(consumerKey: self.credentials.clientId, consumerSecret: self.credentials.clientSecret)
    }
    
    private var headers:[String:String] {
        return [
            "X-Yahoo-App-Id": self.credentials.appId
        ]
    }
    
    /// Requests weather data by location dictionary.
    ///
    /// - Parameters:
    ///   - location: the name of the location, i.e. sunnyvale,ca
    ///   - failure: failure callback
    ///   - success: success callback
    ///   - responseFormat: .xml or .json. default is .json.
    ///   - unit: metric or imperial units. default = .imperial
    
    public func weathers(locationArray: [FetchData.DefaultLocation], failure: @escaping (_ error: OAuthSwiftError) -> Void, success: @escaping (_ response: OAuthSwiftResponse) -> Void,
                                 responseFormat:YahooWeatherAPIResponseType = .json, unit:YahooWeatherAPIUnitType = .metric) {
        locationArray.forEach { (location) in
            
            self.makeRequest(parameters: ["lat":location.lat.description, "lon":location.long.description, "format":responseFormat.rawValue, "u":unit.rawValue], failure: failure, success: success)
        }
        
    }
    
    public func weathers(locationArray: [CityWeathers], failure: @escaping (_ error: OAuthSwiftError) -> Void, success: @escaping (_ response: OAuthSwiftResponse) -> Void,
                         responseFormat:YahooWeatherAPIResponseType = .json, unit:YahooWeatherAPIUnitType = .metric) {
        locationArray.forEach { (location) in
            
            self.makeRequest(parameters: ["lat":location.lat.description, "lon":location.long.description, "format":responseFormat.rawValue, "u":unit.rawValue], failure: failure, success: success)
        }
        
    }
    
    
    
    
    /// Requests weather data by location name.
    ///
    /// - Parameters:
    ///   - location: the name of the location, i.e. sunnyvale,ca
    ///   - failure: failure callback
    ///   - success: success callback
    ///   - responseFormat: .xml or .json. default is .json.
    ///   - unit: metric or imperial units. default = .imperial
    
    public func weather(location:String, failure: @escaping (_ error: OAuthSwiftError) -> Void, success: @escaping (_ response: OAuthSwiftResponse) -> Void, responseFormat:YahooWeatherAPIResponseType = .json, unit:YahooWeatherAPIUnitType = .metric) {
        self.makeRequest(parameters: ["location":location,
                                      "format":responseFormat.rawValue,
                                      "u":unit.rawValue],
                         failure: failure,
                         success: success)
    }
    
    
    
    /// Requests weather data by woeid (Where on Earth ID)
    ///
    /// - Parameters:
    ///   - woeid: The location's woeid
    ///   - failure: failure callback
    ///   - success: success callback
    ///   - responseFormat: .xml or .json. default is .json.
    ///   - unit: metric or imperial units. default = .imperial
    
    public func weather(woeid:String, failure: @escaping (_ error: OAuthSwiftError) -> Void, success: @escaping (_ response: OAuthSwiftResponse) -> Void, responseFormat:YahooWeatherAPIResponseType = .json, unit:YahooWeatherAPIUnitType = .metric) {
        self.makeRequest(parameters: ["woeid":woeid,
                                      "format":responseFormat.rawValue,
                                      "u":unit.rawValue],
                         failure: failure,
                         success: success)
    }
    
    
    /// Requests weather data by latitude and longitude
    ///
    /// - Parameters:
    ///   - lat: latitude
    ///   - lon: longiture
    ///   - failure: failure callback
    ///   - success: success callback
    ///   - responseFormat: .xml or .json. default is .json.
    ///   - unit: metric or imperial units. default = .imperial
    public func weather(lat:String, lon:String, failure: @escaping (_ error: OAuthSwiftError) -> Void, success: @escaping (_ response: OAuthSwiftResponse) -> Void, responseFormat:YahooWeatherAPIResponseType = .json, unit:YahooWeatherAPIUnitType = .metric) {
        self.makeRequest(parameters: ["lat":lat, "lon":lon, "format":responseFormat.rawValue, "u":unit.rawValue], failure: failure, success: success)
    }
    
    
    /// Performs the API request with the OAuthSwift client
    ///
    /// - Parameters:
    ///   - parameters: Any URL parameters to pass to the endpoint.
    ///   - failure: failure callback
    ///   - success: success callback
    private func makeRequest(parameters:[String:String], failure: @escaping (_ error: OAuthSwiftError) -> Void, success: @escaping (_ response: OAuthSwiftResponse) -> Void) {
        self.oauth?.client.request(self.url, method: .GET, parameters: parameters, headers: self.headers, body: nil, checkTokenExpiration: true, success: success, failure: failure)
    }
    
}

