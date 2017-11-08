//
//  NavigationController.swift
//  weather
//
//  Created by Leon Erath on 20.10.17.
//  Copyright © 2017 Leon Erath. All rights reserved.
//

import UIKit

class NavigationController : UIViewController{
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var cityString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        imageView.addSubview(blurEffectView)
        
        
        if let location = SettingsController.shared.location{
            log.info("Saved location found.")
            performSegue(withIdentifier: "weather", sender: self)
        }
        
        
    }
    
    @IBAction func onClick(_ sender: Any) {
        if let text = textField.text{
            SettingsController.shared.location = text
            performSegue(withIdentifier: "weather", sender: sender)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    

    
    
}
