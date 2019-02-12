//
//  UIViewController.swift
//  weRide
//
//  Created by Ashok Gupta on 28/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import Foundation


extension UIViewController {
    
    func pushToDashboard() {
        
        let window = UIApplication.shared.keyWindow
        let rootNav = window?.rootViewController as! UINavigationController
        let mainTab = Utils.mainStoryboardController(identifier: Constant.kMainTab_VC)
        rootNav.navigationBar.isHidden = false
        rootNav.setViewControllers([mainTab], animated: true)
    }
    
    
}
