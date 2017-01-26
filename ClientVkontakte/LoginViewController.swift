//
//  LoginViewController.swift
//  ClientVkontakte
//
//  Created by Сергей Полозов on 25.01.17.
//  Copyright © 2017 Сергей Полозов. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBAction func login(_ sender: Any) {
        
        let authUrl = URL(string: "https://oauth.vk.com/authorize?client_id=5832945&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&scope=friends&response_type=token&v=5.62")
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(authUrl!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(authUrl!)
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
