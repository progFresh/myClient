//
//  InformationViewController.swift
//  ClientVkontakte
//
//  Created by Сергей Полозов on 02.02.17.
//  Copyright © 2017 Сергей Полозов. All rights reserved.
//

import UIKit
import Alamofire

class InformationViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var mainPhoto: UIImageView!
    var information = [String]()
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        information.removeAll()
        
        setConstraints()
        let keyChain = KeyChain()
        let token = keyChain.getToken()
        
        fillInformationAboutUser(token: token)
    }
    
    func loadFromDataBase() {
        print("poka cto net Bazi Dannih")
    }
    
    func backToLoginViewController() {
        let theTransition = storyboard?.instantiateViewController(withIdentifier: "LoginID")
        present(theTransition!, animated: true, completion: nil)
    }
    
    func fillInformationAboutUser (token: String) {
        Alamofire.request("https://api.vk.com/method/users.get?fields=bdate,sex,contacts,photo_max,connections&access_token=\(token)").responseJSON { response in
            if response.error != nil {
                self.loadFromDataBase()
            } else if let result = response.result.value {
                let JSON = result as! NSDictionary
                if let arrayOfDictionary = JSON.value(forKey: "response") as? [NSDictionary]{
                    
                    let dictionary = arrayOfDictionary[0]
                    let name = dictionary.value(forKey: "first_name") as! String
                    let secondName = dictionary.value(forKey: "last_name") as! String
                    self.information.append("\(name) \(secondName)")
                    if let sex = dictionary.value(forKey: "sex") as! Int? {
                        if sex == 2 {
                            self.information.append("sex: man")
                        } else {
                            self.information.append("sex: woman")
                        }
                    }
                    if let bdate = dictionary.value(forKey: "bdate") as? String {
                        self.information.append("birthday: \(bdate)")
                    }
                    if let phone = dictionary.value(forKey: "mobile_phone") as? String {
                        self.information.append("phone: \(phone)")
                    }
                    if let homePhone = dictionary.value(forKey: "home_phone") as? String {
                        self.information.append("home phone: \(homePhone)")
                    }
                    if let skype = dictionary.value(forKey: "skype") as? String {
                        self.information.append("skype: \(skype)")
                    }
                    if let instagram = dictionary.value(forKey: "instagram") as? String {
                        self.information.append("instagram: \(instagram)")
                    }
                    print(self.information)
                } else {
                    print("error of token")
                    self.backToLoginViewController()
                }
            }
        }
    }
    
    func setConstraints () {
        let mainView = self.view
        let screenSize = UIScreen.main.bounds
        self.mainPhoto.translatesAutoresizingMaskIntoConstraints = false
        //mainPhoto = 0 from left edge of screen
        let leadingConstraint = NSLayoutConstraint(item: mainPhoto, attribute: .leading, relatedBy: .equal, toItem: mainView, attribute: .leading, multiplier: 1.0, constant: 0)
        //mainPhoto = 63 from top of screen
        let topConstraint = NSLayoutConstraint(item: mainPhoto, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1.0, constant: 64)
        //mainPhoto width
        let mainPhotoWidth = NSLayoutConstraint(item: mainPhoto, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: (screenSize.width/2))
        //mainPhoto height
        let mainPhotoHeight = NSLayoutConstraint(item: mainPhoto, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: (screenSize.width/2))
        self.view.addConstraints([leadingConstraint, topConstraint, mainPhotoWidth, mainPhotoHeight])
        
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        //Label = 5 from left edge of photo
        let leadingConstraintLabel = NSLayoutConstraint(item: infoLabel, attribute: .leading, relatedBy: .equal, toItem: mainPhoto, attribute: .trailing, multiplier: 1.0, constant: 5)
        //Label = 63 from top of superView
        let topConstraintLabel = NSLayoutConstraint(item: infoLabel, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1.0, constant: 64)
        //Label width
        let WidthLabel = NSLayoutConstraint(item: infoLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: (screenSize.width/2))
        self.view.addConstraints([leadingConstraintLabel, topConstraintLabel, WidthLabel])
    }

}
