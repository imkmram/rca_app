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
}
