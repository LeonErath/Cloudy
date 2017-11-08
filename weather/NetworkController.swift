//
//  networkController.swift
//  weather
//
//  Created by Leon Erath on 03.11.17.
//  Copyright © 2017 Leon Erath. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public var cityString : String = ""
let key = "88e8ca00173155df504118c5aee531dd"
let baseURL = "https://api.openweathermap.org/data/2.5/weather"
let forecastuRL = "https://api.openweathermap.org/data/2.5/forecast"

class NetworkController{
    
    func getWeather(from city: String,callBack: @escaping (_ :DefaultDataResponse) -> Void ){
        let parameters: Parameters = ["APPID"   :   key,
                                      "q"       :   city,
                                      "units"   :   "metric",
                                      "lang"    :   "de"]
        if NetworkReachabilityManager()!.isReachable {
            Alamofire.request(baseURL,
                          method: .get,
                          parameters:parameters).response{ response in
                                callBack(response)
                            }
        }else{
            log.error("Network is not reachable.")
          
        }
        
    }
}
