//
//  Enums.swift
//  RCA
//
//  Created by Ashok Gupta on 19/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation


enum LeftMenu: Int {
    case home = 0
    case about_us
    case privacy_policy
    //    case nonMenu
}

enum CustomError : Error {
    case NoNetwork
    case BadRequest
    case InternalServerError
    case OtherError
    
    var localizedDescription: String {
        
        switch self {
        case .NoNetwork:
            return NSLocalizedString("No Network, check your connection", comment: "Custom Error")
        case .BadRequest:
            return NSLocalizedString("Request error, try later", comment: "Custom Error")
        case .InternalServerError:
            return NSLocalizedString("Server not responding, try later", comment: "Custom Error")
        case .OtherError:
            return NSLocalizedString("Something went wrong....", comment: "Custom Error")
        }
    }
}

enum TravelType: String {
    
    case Departure = "Departure"
    case Transit = "Transit"
    case Arrival = "Arrival"
}

enum RateType: String {
    case Person = "Per Person"
    case Group = "Group"
}


