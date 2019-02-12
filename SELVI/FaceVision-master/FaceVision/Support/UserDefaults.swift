//
//  UserDefaults.swift
//  FaceVision
//
//  Created by Ashok Gupta on 22/01/19.
//  Copyright © 2019 IntelligentBee. All rights reserved.
//

import Foundation

enum UserDefaultsKeys : String {
    case isLoggedIn
    case userID
    case userName
    case emailID
    case mobileNo
    case image
    case savedImage
    case lastAPICall
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
    func setUserID(value: Int){
        set(value, forKey: UserDefaultsKeys.userID.rawValue)
        //synchronize()
    }
    
    //MARK: Retrieve User Data
    func getUserID() -> Int{
        return value(forKey: UserDefaultsKeys.userID.rawValue) as! Int
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
    
    func setLastAPICall(value: String) {
        set(value, forKey: UserDefaultsKeys.lastAPICall.rawValue)
    }
    
    func getLastAPICall() -> String {
        return value(forKey: UserDefaultsKeys.lastAPICall.rawValue) as! String
    }
    
    func setSavedImage(value: Image)  {
        
        if self.object(forKey: UserDefaultsKeys.savedImage.rawValue) != nil {
            
            let decoded  = object(forKey: UserDefaultsKeys.savedImage.rawValue) as! Data
            
            do {
                var gallery = try JSONDecoder().decode(Gallery.self, from: decoded)
                gallery.images?.append(value)
                
                let encodedData = try? JSONEncoder().encode(gallery)
                if let data = encodedData {
                    let str = String(data: data, encoding: .utf8)
                    set(data, forKey: UserDefaultsKeys.savedImage.rawValue)
                }
                
            } catch  {
                
            }
        }
        else {
            
            var images:[Image] = [Image]()
            images.append(value)
            let gallery = Gallery(list: images)
            
            let encodedData = try? JSONEncoder().encode(gallery)
            if let data = encodedData {
                let str = String(data: data, encoding: .utf8)
                set(data, forKey: UserDefaultsKeys.savedImage.rawValue)
            }
        }
    }
    
    func getSavedImages() -> Gallery? {
        
        if  let object  = object(forKey: UserDefaultsKeys.savedImage.rawValue) {
            
            let decoded = object as! Data
            
            do {
                let gallery = try JSONDecoder().decode(Gallery.self, from: decoded)
                return gallery
            
            } catch  {
            }
        }
        return nil
    }
    
    func removeAllSavedImage() {
        removeObject(forKey: UserDefaultsKeys.savedImage.rawValue)
        
//        let decoded  = object(forKey: UserDefaultsKeys.savedImage.rawValue) as! Data
//        do {
//            var gallery = try JSONDecoder().decode(Gallery.self, from: decoded)
//            
//            
//            let newList = gallery.images?.filter({
//                if $0.image_identifier == idenfifier {
//                    return false
//                }
//                else {return true}
//            })
//            
//            gallery.images = newList
//            let encodedData = try? JSONEncoder().encode(gallery)
//            if let data = encodedData {
//                let str = String(data: data, encoding: .utf8)
//                set(data, forKey: UserDefaultsKeys.savedImage.rawValue)
//            }
//        } catch  {
//            
//        }
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
