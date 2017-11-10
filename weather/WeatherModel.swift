//
//  WeatherModel.swift
//  weather
//
//  Created by Leon Erath on 08.11.17.
//  Copyright © 2017 Leon Erath. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


typealias weatherModelCompletionHandler = ( _ model : WeatherData ) -> Void

class WeatherModel : WeatherDataProvider{
    var weatherDataConsumer: WeatherDataConsumer?
    var weatherData : WeatherData
    var completionHandler: weatherModelCompletionHandler?
    var networkController : NetworkController
    
    init() {
        self.networkController = NetworkController()
        self.weatherData = WeatherData()
    }
    
    func fetchWeather(from cityName: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        networkController.getWeather(from: cityName){ response in
            if  response.data != nil{
                let json = JSON(data:response.data!)
                let cod = json["cod"].intValue
                if cod == 200{
                    log.info("Request successful on location:"+cityName)
                    self.weatherData.cityName = json["name"].stringValue
                    for currentWeather in json["weather"].arrayValue{
                        if let imageid = currentWeather["icon"].string{
                            self.weatherData.weatherImage = UIImage.init(named: imageid)
                            self.weatherData.description = currentWeather["description"].stringValue
                        }
                    }
                    self.weatherData.temperature = json["main"]["temp"].doubleValue
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.weatherDataConsumer?.receiveWeatherData(model: self.weatherData )
                    
                }else{
                    log.error("URL Request NOT successful. City was not found")
                    self.weatherData.cityName = "City not found"
                    self.weatherData.weatherImage = #imageLiteral(resourceName: "sadcloud")
                    self.weatherData.description = ""
                    self.weatherData.temperature = 0
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.weatherDataConsumer?.receiveWeatherData(model: self.weatherData )
                }
            }else{
                log.error("response is nil")
            }
        }
        
        
        
        
    }
    
    
    
}


