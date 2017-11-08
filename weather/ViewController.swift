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
import AVFoundation


class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,WeatherDataConsumer,SettingsControllerDelegate {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ldescription: UILabel!
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var intervallPicker: UIPickerView!
    
    public var cityString : String = ""
    var audioplayer : AVAudioPlayer = AVAudioPlayer()
    
    let networkController = NetworkController()
    let settingsController = SettingsController.shared
    
    var savedlocation: String = ""
    var updateTimer: Timer? = nil
    var networkErrorShown: Bool = false
    
    var weatherDataProvider : WeatherDataProvider?
    
    func receiveWeatherData(model: WeatherData) {
            self.cityLabel.text = model.cityName
            self.imageView.image = model.weatherImage
            self.temperature.text = "\(model.temperature)°C"
            self.ldescription.text = model.description
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        weatherDataProvider = WeatherModel()
        weatherDataProvider?.weatherDataConsumer = self
    }
    
    var pickerData: [String] = ["1 Sekunde","5 Sekunden","10 Sekunden", "60 Sekunden"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        intervallPicker.isHidden = true
        self.updateTimer?.invalidate()
        switch row {
        case 0:
            self.settingsController.refreshInterval = 1
        case 1:
            self.settingsController.refreshInterval = 5
        case 2:
            self.settingsController.refreshInterval = 10
        case 3:
           self.settingsController.refreshInterval = 30
        default:
           self.settingsController.refreshInterval = 60
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        do{
//            if !audioplayer.isPlaying{
//                audioplayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "sample", ofType: "mp3")!))
//                audioplayer.prepareToPlay()
//                audioplayer.play()
//            }
//        }catch{
//            log.error("cant play music")
//        }
        
        self.settingsController.delegate = self
        self.intervallPicker.delegate = self
        self.intervallPicker.dataSource = self
        intervallPicker.isHidden = true
        
        blurBackground()
        if let location = SettingsController.shared.location {
            cityString = location
            updateTimer = Timer.scheduledTimer(timeInterval: Double(settingsController.refreshInterval), target: self, selector: #selector(self.updateWeather), userInfo: nil, repeats: true)
            updateWeather()
        }else{
            log.error("no location found from SettingsController")
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func updateWeather() {
        self.weatherDataProvider?.fetchWeather(from: cityString)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        updateTimer?.invalidate()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func blurBackground(){
        background.image = #imageLiteral(resourceName: "background2")
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        background.addSubview(blurEffectView)
    }
    
    @IBAction func refreshClick(_ sender: Any) {
        intervallPicker.isHidden = false
    }
    
    
    func locationDidChange(location: String?) {
        if let loc = location {
              cityString = loc
        }
    }
    
    func refreshIntervalDidChange(refreshInterval: Int) {
        updateTimer = Timer.scheduledTimer(timeInterval: Double(refreshInterval), target: self, selector: #selector(self.updateWeather), userInfo: nil, repeats: true)
    }
    
}

