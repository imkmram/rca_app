//
//  Utils.swift
//  RCA
//
//  Created by Ashok Gupta on 06/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation
import UIKit

struct Utils {
    
   static func getMainStoryboardController(identifier: String) -> UIViewController {
        
        let storyboard = UIStoryboard(name: Constant.STORYBOARD_Main, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
   static func getE_visaStoryboardController(identifier: String) -> UIViewController {
        
        let storyboard = UIStoryboard(name: Constant.STORYBOARD_E_Visa, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func getMeet_AssistStoryboardController(identifier: String) -> UIViewController {
        
        let storyboard = UIStoryboard(name: Constant.STORYBOARD_Meet_Assist, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func getCalendarStoryboardController(identifier: String) -> UIViewController {
        
        let storyboard = UIStoryboard(name: Constant.STORYBOARD_Calendar, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static var ruppeSymbol: String {
        return "\u{20B9}"
       
    }
    static var dollarSymbol: String {
        return "\u{0024}"
    }
    static var bullet: String {
        return "\u{27a4}"
    }
    
}
