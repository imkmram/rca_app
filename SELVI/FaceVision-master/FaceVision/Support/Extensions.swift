//
//  Extensions.swift
//  FaceVision
//
//  Created by Ashok Gupta on 11/02/19.
//  Copyright © 2019 IntelligentBee. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    static func getCurrentDate() -> String {
        let formatString = "dd-MM-yyyy"
        let format = DateFormatter()
        format.dateFormat = formatString
        let strDate = format.string(from: Date())
        
        return strDate
    }
}

extension UIViewController {
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func fetchUsers(url:URL, method:String, parameter: String, completion: @escaping (ResponseResult<BaseModel>) -> Void) {
        NetworkClient.get(url: url, method: method, parameter: parameter) { (result) in
            completion(result as ResponseResult<BaseModel>)
        }
    }
    
    func fetchCountries(url:URL, method:String, completion: @escaping (ResponseResult<BaseModel>) -> Void) {
        NetworkClient.get(url: url, method: method, parameter: nil) { (result) in
            completion(result as ResponseResult<BaseModel>)
        }
    }
    
    func showToast(title:String, message:String) {
        let toast = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        self.present(toast, animated: true, completion: nil)
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
            toast.dismiss(animated: true, completion: {
                timer.invalidate()
            })
        }
    }
}

extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
    
    var isValidEmail: Bool {
        return !isEmpty && range(of: "([a-zA-Z0-9._-]+@[a-z]+[.]+[a-z]+)", options: .regularExpression) == nil
    }
}
