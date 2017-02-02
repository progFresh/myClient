//
//  ViewController.swift
//  ClientVkontakte
//
//  Created by Сергей Полозов on 04.01.17.
//  Copyright © 2017 Сергей Полозов. All rights reserved.
//

import UIKit
import Locksmith

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isThereToken = Locksmith.loadDataForUserAccount(userAccount: "com.Pol.s.ClientVkontakte")
        if isThereToken != nil {
            //check token
            // continue to tab bar
            delay(1.0) {
                self.performSegue(withIdentifier: "ToTabBar", sender: nil)
            }
        } else {
            delay(1.0) {
                self.performSegue(withIdentifier: "ToLogin", sender: nil)
            }
        }
    }
    
    func checkToken () {
        
    }

}

