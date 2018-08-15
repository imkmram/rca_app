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
        "four":"4", "for":"4",
        "five":"5",
        "six":"6",
        "seven":"7",
        "eight":"8",
        "nine":"9",
        "ten":"10",
        "eleven":"11",
        "level":"11",
        "january":"01 - ", "febuary":"02 - ", "march":"03 - ", "april":"04 - ", "may":"05 - ", "june":"06 - ", "july":"07 - ", "august":"08 - ", "september":"09 - ", "october":"10 - ", "november":"11 - ", "december":"12 - ",
        "first":"01 - ", "second":"02 - ", "third":"03 - ", "forth":"04 - ", "fifth":"05 - ", "eleventh":"11 -", "tewelth":"12 - ", "thirteenth":"13 - ", "fourteenth":"14 - ", "fifteenth":"15 - ", "sixteenth":"16 - ", "seventeenth":"17 - ", "eighteenth":"18 - ", "nineteenth":"19 - ", "twentyth":"20 - "
    ]
    
    func onlyString(value:String) -> (value:String?, isValid:Bool) {
        
            let regex = "[A-Za-z]"
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            let result = predicate.evaluate(with: value)
            if result {
                
                return (value, true)
            }
            else {
                return  ("Only characters allowed", false)
            }
    }
    
    func validate(value:String, questionID:Int) -> (String, Bool){
        
        let oldStr = value.lowercased()
        var newStr = oldStr
       
      let result =  myDictionary.filter { (key, value) -> Bool in
            if newStr.contains(key) {
                
                newStr = oldStr.replacingOccurrences(of: key.capitalized, with: value)
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
        case 1 :
            let returnedValue = onlyString(value: newStr)
                return (returnedValue.value?.capitalized ?? newStr, returnedValue.isValid)
        case 2, 3, 4, 5, 6, 7 :
             return (newStr.capitalized, true)
        case 8 :
            newStr = newStr.lowercased()
            return (newStr.trimmingCharacters(in: .whitespaces), true)
        default:
            return (newStr, true)
        }
    }
}
