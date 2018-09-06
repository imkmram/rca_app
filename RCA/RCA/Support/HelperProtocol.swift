//
//  Enums.swift
//  RCA
//
//  Created by Ashok Gupta on 27/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation

protocol ServiceModel {
    
    var title: String? {get set}
    var product_type : String? {get set}
    var product_id : String? {get set}
    var airport : String? {get set}
    var airport_code : String? {get set}
    var country : String? {get set}
    var country_code : String? {get set}
    var city : String? {get set}
}
