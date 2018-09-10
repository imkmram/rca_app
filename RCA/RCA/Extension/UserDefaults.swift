//
//  UserDefaults.swift
//  RCA
//
//  Created by Ashok Gupta on 07/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static func exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
