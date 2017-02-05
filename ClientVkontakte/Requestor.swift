//
//  Requestor.swift
//  ClientVkontakte
//
//  Created by Сергей Полозов on 04.02.17.
//  Copyright © 2017 Сергей Полозов. All rights reserved.
//

//import Foundation
//import Alamofire
//
//class Requestor {
//    
//    func getName (token: String)  {
//        Alamofire.request("https://api.vk.com/method/users.get?fields=bdate,sex,contacts,photo_max_orig&access_token=\(token)").responseJSON { response in
//            if response.error != nil {
//                print("internet is off")
//            } else
//                if let result = response.result.value {
//                    let JSON = result as! NSDictionary
//                    
//            }
//        }
//    }
//
//}
