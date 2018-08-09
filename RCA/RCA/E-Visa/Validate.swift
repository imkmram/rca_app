//
//  Validate.swift
//  RCA
//
//  Created by TWC on 09/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation

class Validate {
    
    let rejectedWord:[String] = ["Idiot", "Sex"]
    
    let myDictionary:[String:String] = ["idiot":"Ixxx", "sex":"Sxx", "at the rate":"@", "at the":"@"]
    
    func firstName(name:String) -> String? {
        
        do{
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z].*", options: .caseInsensitive)
            
            if regex.firstMatch(in: name, options: .reportCompletion, range: NSRange(location: 0, length: name.length)) != nil {
                
            }
            else {
             //   if myDictionary.contains(name) {
                    
                    //let result =  name.replacingCharacters(in: NSRange(location:1, length: name.length - 1 ), with: String(repeating: "x", count: name.length))
               // }
            }
        }
        catch {
            
        }
    
        return nil
    }
    
    func validateEmail(email:String) {
        
        var newStr = email.lowercased()
        for value in myDictionary {
            
        }
        

        newStr = newStr.replacingOccurrences(of: "at the rate", with: "@")
        
    }
}
