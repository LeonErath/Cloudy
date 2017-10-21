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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewControllerB = segue.destination as? ViewController {
            viewControllerB.cityString = textField.text!
        }
    }
    

    
    
}
