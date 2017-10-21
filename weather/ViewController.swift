//
//  ViewController.swift
//  weather
//
//  Created by Leon Erath on 13.10.17.
//  Copyright © 2017 Leon Erath. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ldescription: UILabel!
    
    @IBOutlet weak var imageViewFor1: UIImageView!
    @IBOutlet weak var imageViewFor2: UIImageView!
    @IBOutlet weak var imageViewFor3: UIImageView!
    
    public var cityString : String = ""
    let key = "88e8ca00173155df504118c5aee531dd"
    let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    let forecastuRL = "https://api.openweathermap.org/data/2.5/forecast"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        makeRequest()
        getForecast()
        print("city:"+cityString)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func makeRequest(){
        let parameters: Parameters = ["APPID": key,
                                      "q":cityString,
                                      "units":"metric",
                                      "lang":"de"]
        Alamofire.request(baseURL,method: .get,parameters:parameters).responseJSON { response in
            print("Result: \(response.result)")                         // response serialization result
            
            if  response.data != nil{
                let json = JSON(data:response.data!)
                let name = json["name"].stringValue
                self.city.text = name
                let weather = json["weather"].arrayValue
                for currentWeather in weather{
                    if let imageid = currentWeather["icon"].string{
                        self.imageView.image = UIImage.init(named: imageid)
                        self.ldescription.text = currentWeather["description"].stringValue
                    }
                }
                let main = json["main"]
                let temp = main["temp"].doubleValue
                self.temperature.text = "\(temp)°C"
                
            }
            
        }
    
    }
    func getForecast(){
        let parameters: Parameters = ["APPID": key,
                                      "q":cityString,
                                      "units":"metric",
                                      "lang":"de",
                                      "type":"accurate"]
        Alamofire.request(forecastuRL,method: .get,parameters:parameters).responseJSON { response in
            print("Result: \(response.result)")                         // response serialization result
            
            if  response.data != nil{
                let json = JSON(data:response.data!)
                let list = json["list"].arrayValue
          
                let weather = list[0]["weather"].arrayValue
                    for currentWeather in weather{
                        if let imageid = currentWeather["icon"].string{
                            self.imageViewFor1.image = UIImage.init(named: imageid)
                           
                        }
                }
                let weather2 = list[1]["weather"].arrayValue
                for currentWeather in weather2{
                    if let imageid = currentWeather["icon"].string{
                        self.imageViewFor2.image = UIImage.init(named: imageid)
                        
                    }
                }
                let weather3 = list[2]["weather"].arrayValue
                for currentWeather in weather3{
                    if let imageid = currentWeather["icon"].string{
                        self.imageViewFor3.image = UIImage.init(named: imageid)
          
                    }
                }
             
                
            }
            
        }
    }
}

