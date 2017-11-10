//
//  SettingsController.swift
//  WeathIt
//
//  Created by Niklas Korz on 27/10/17.
//  Copyright © 2017 Niklas Korz. All rights reserved.
//

import UIKit

protocol SettingsControllerDelegate {
    func locationDidChange(location: String?)
    func refreshIntervalDidChange(refreshInterval: Int )
}

class SettingsController {
    static let shared = SettingsController()
    let defaults = UserDefaults.standard
    var delegate: SettingsControllerDelegate? = nil
    
    var location: String? {
        set {
            if let value = newValue {
                defaults.set(value, forKey: "location")
            } else {
                defaults.removeObject(forKey: "location")
            }
            delegate?.locationDidChange(location: newValue)
        }
        get {
            if let loc = defaults.string(forKey: "location"){
                log.info("Found saved location:"+loc)
            }
            return defaults.string(forKey: "location")
        }
    }
    
    var refreshInterval: Int {
        set {
            defaults.set(newValue, forKey: "refreshInterval")
            delegate?.refreshIntervalDidChange(refreshInterval: newValue)
        }
        get {
            if defaults.integer(forKey: "refreshInterval") != 0{
                log.info("Found saved refreshInterval \(defaults.integer(forKey: "refreshInterval"))")
                return defaults.integer(forKey: "refreshInterval")
            }else{
                return 30
            }
        }
    }
}

