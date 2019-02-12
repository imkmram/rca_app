//
//  VehicleModel.swift
//  weRide
//
//  Created by Ashok Gupta on 11/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import Foundation

protocol VehicleModelDelegate {
    
}

class VehicleModel {
    
    var vehicleID: String?
    private var regNo: String?
    var type: VehicleType!
    private var make: String?
    private var yearOfMake: String?
    private var color: String?
    private var engineCapacity: String?
    private var chassisNumber: String?
    var insurer: String?
    var expiryDate: String?
    var insuredAmt: String?
    
    var RegNo: String?  {
        set {
            regNo = newValue
        }
        get {
            return regNo
        }
    }
    
    var Make: String?  {
        set {
            make = newValue
        }
        get {
            return make
        }
    }
    
    var MakeYear: String?  {
        set {
            yearOfMake = newValue
        }
        get {
            return yearOfMake
        }
    }
    var Color: String?  {
        set {
            color = newValue
        }
        get {
            return color
        }
    }
    var ChassisNumber: String?  {
        set {
            chassisNumber = newValue
        }
        get {
            return chassisNumber
        }
    }
    var EngineCapacity: String?  {
        set {
            engineCapacity = newValue
        }
        get {
            return engineCapacity
        }
    }
}
