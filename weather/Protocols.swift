//
//  Protocols.swift
//  weather
//
//  Created by Leon Erath on 08.11.17.
//  Copyright © 2017 Leon Erath. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherDataProvider {
    
    var weatherDataConsumer : WeatherDataConsumer? { get set }
    
    func fetchWeather(from cityName : String )
}

protocol WeatherDataConsumer {
    func receiveWeatherData( model : WeatherData )
}

struct WeatherData {
    
    var temperature: Double = 0.0
    var description: String = ""
    var cityName: String = ""
    var date: String = ""
    var weatherImage: UIImage?
    
    
    init() {
        temperature = 0
        description = ""
        cityName = ""
        date = ""
        weatherImage = nil
    }
    
    init(temperature: Double,description:String,cityName:String,date:String,weatherImage: UIImage) {
        self.temperature = temperature
        self.description = description
        self.cityName = cityName
        self.date = date
        self.weatherImage = weatherImage
    }
    
  
   
   
}
