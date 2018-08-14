//
//  Validate.swift
//  RCA
//
//  Created by TWC on 09/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation

class Validate {
    
    let myDictionary:[String:String] = [
        "idiot":"Ixxx",
        "sex":"Sxx",
        "at the rate":"@",
        "at the":"@",
        "at": "@",
        "dot":".",
        "to":"2",
        "do":"2",
        "one":"1",
        "two":"2",
        "three":"3",
        "four":"4",
        "five":"5",
        "six":"6",
        "seven":"7",
        "eight":"8",
        "nine":"9",
        "ten":"10",
        "eleven":"11",
        "level":"11"
    ]
    
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
    
    func validate(email:String, questionID:Int) -> String {
        
        var newStr = email.lowercased()
       
      let result =  myDictionary.filter { (key, value) -> Bool in
            if newStr.contains(key) {
                
                newStr = newStr.replacingOccurrences(of: key, with: value)
                return true
            }
            else {
                return false
            }
        }
        
    
        print("======================VALIDATE===============")
       print(result.values)
        print(newStr)
        
        switch questionID {
        case 1, 2, 3, 4, 5, 6, 7 :
            return newStr.capitalized
        case 8 :
            newStr = newStr.lowercased()
            return newStr.trimmingCharacters(in: .whitespaces)
        default:
            return newStr
        }
    }
}
