//
//  KeyChain.swift
//  ClientVkontakte
//
//  Created by Сергей Полозов on 04.02.17.
//  Copyright © 2017 Сергей Полозов. All rights reserved.
//

import Foundation
import Locksmith

class KeyChain {
    
    private let userAccount = "com.Pol.s.ClientVkontakte"
    
    func isThereToken () -> Bool {
        let dictionaryToken = Locksmith.loadDataForUserAccount(userAccount: userAccount)
        if dictionaryToken == nil {
            return false
        } else {
            return true
        }
    }
    
    func saveToken(value: String) {
        if self.isThereToken() == true {
            do {
                try Locksmith.updateData(data: ["token" : value], forUserAccount: userAccount)
            } catch {
                //can't update token
            }
            print("token is updated")
        } else {
            do {
                try Locksmith.saveData(data: ["token":  value], forUserAccount: userAccount)
            } catch {
                // can't save the token to KeyChain
            }
            print("token is saved")
        }
    }
    
    func getToken () -> String {
        if let dictionaryToken = Locksmith.loadDataForUserAccount(userAccount: userAccount) as? NSDictionary {
            return dictionaryToken.value(forKey: "token") as! String
        } else {
            return "Error getting token"
        }
    }
    
    func deleteToken() {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: userAccount)
            print("token is removed")
        } catch {
            //
        }
    }

}
