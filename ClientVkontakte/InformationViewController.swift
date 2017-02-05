//
//  InformationViewController.swift
//  ClientVkontakte
//
//  Created by Сергей Полозов on 02.02.17.
//  Copyright © 2017 Сергей Полозов. All rights reserved.
//

import UIKit
import Alamofire

class InformationViewController: UIViewController, UITableViewDataSource {
    
    var strings = [String]()

    @IBOutlet weak var tableView: UITableView!
    let informationList = ["privet", "kak dela", "u tebya"]
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        let keyChain = KeyChain()
        let token = keyChain.getToken()
        
        getName(token: token)
    }
    
    func loadFromDataBase() {
        print("poka cto net Bazi Dannih")
    }
    
    func backToLoginViewController() {
        let theTransition = storyboard?.instantiateViewController(withIdentifier: "LoginID")
        present(theTransition!, animated: true, completion: nil)
    }
    
    func getName (token: String) {
        Alamofire.request("https://api.vk.com/method/users.get?fields=bdate,sex,contacts,photo_max_orig&access_token=\(token)").responseJSON { response in
            if response.error != nil {
                self.loadFromDataBase()
            } else
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    if let arrayOfDictionary = JSON.value(forKey: "response") as? [NSDictionary]{
                        let dictionary = arrayOfDictionary[0] as! NSDictionary
                        
                        let name = dictionary.value(forKey: "first_name") as! String
                        let secondName = dictionary.value(forKey: "last_name") as! String
                        self.strings.append("\(name) \(secondName)")
                        
                        print(dictionary)
                    } else {
                        print("error of token")
                        self.backToLoginViewController()
                    }
            }
        }
    }
    
    // Mark : TableView
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return informationList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        tableCell.textLabel?.text = informationList[indexPath.row]
        return tableCell
    }

}
