//
//  UserDefaults.swift
//  weRide
//
//  Created by Ashok Gupta on 28/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import Foundation

enum UserDefaultsKeys : String {
    case isLoggedIn
    case userID
    case userName
    case emailID
    case mobileNo
    case image
}

extension UserDefaults{
    
    //MARK: Check Login
    func setLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        //synchronize()
    }
    
    func isLoggedIn()-> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
    //MARK: Save User Data
    func setUserID(value: String){
        set(value, forKey: UserDefaultsKeys.userID.rawValue)
        //synchronize()
    }
    
    //MARK: Retrieve User Data
    func getUserID() -> String{
        return value(forKey: UserDefaultsKeys.userID.rawValue) as! String
    }
    
    func setEmailID(value: String) {
        set(value, forKey: UserDefaultsKeys.emailID.rawValue)
    }
    
    func getEmail() -> String {
        return value(forKey: UserDefaultsKeys.emailID.rawValue) as! String
    }
    
    func setUserName(value: String) {
        set(value, forKey: UserDefaultsKeys.userName.rawValue)
    }
    
    func getUserName() -> String {
        return value(forKey: UserDefaultsKeys.userName.rawValue) as! String
    }
    
    func setMobileNo(value: String) {
        set(value, forKey: UserDefaultsKeys.mobileNo.rawValue)
    }
    
    func getMobileNo() -> String {
        return value(forKey: UserDefaultsKeys.mobileNo.rawValue) as! String
    }
    
    func setProfileImage(value: String) {
        set(value, forKey: UserDefaultsKeys.image.rawValue)
    }
    
    func getProfileImage() -> String {
        return value(forKey: UserDefaultsKeys.image.rawValue) as! String
    }

    func reset() {
        removeObject(forKey: UserDefaultsKeys.userID.rawValue)
         removeObject(forKey: UserDefaultsKeys.userName.rawValue)
         removeObject(forKey: UserDefaultsKeys.emailID.rawValue)
         removeObject(forKey: UserDefaultsKeys.mobileNo.rawValue)
        removeObject(forKey: UserDefaultsKeys.image.rawValue)
        
        set(false, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
}
