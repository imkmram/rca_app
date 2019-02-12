//
//  Enums.swift
//  weRide
//
//  Created by Ashok Gupta on 24/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import Foundation

enum CustomError : Error {
    case NoNetwork
    case BadRequest
    case InternalServerError
    case OtherError
    case NoData
    case OTPError
    case DatabaseError
    case UserExsits
    case FieldValidationError
    case NonVerifiedUser
    case InvalidUserName
    case InvalidPassword
    case InvalidOTP
    case Success
    case Delete
    case Logout
    case NoRoutes

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
        case .NoData:
            return NSLocalizedString("No Data available", comment: "Custom Error")
        case .OTPError:
            return "Unable to send OTP, try Resend OTP"
        case .DatabaseError:
            return "Unable to create account, try later"
        case .UserExsits:
            return "User already registered, Go to Login"
        case .FieldValidationError:
            return "Invalid input"
        case .NonVerifiedUser:
            return "Email not verified, please verify with OTP"
        case .InvalidUserName:
            return "You have entered a wrong email id"
        case .InvalidPassword:
            return "Invalid password."
        case .InvalidOTP:
            return "Invalid OTP, click on Resend OTP"
        case .Success:
            return "Record updated successfully"
        case .Delete:
            return "Deleted successfully"
        case .Logout:
            return "Tap OK to logout else cancel"
        case .NoRoutes:
            return "No routes defined"
        }
    }
}

enum VehicleType: String {
    case Car = "Car"
    case Bike = "Bike"
    case Other = "Other"
}

enum Screen: String {
    case ADD = "New Ride"
    case VIEW = "View Ride"
    case DEFAULT = ""
}
enum ParticipantType {
    case OWNER
    case CO_RIDER
}
enum GOOGLE_CallType {
    case ROUTE
    case DIRECTION
}

enum WayPointDataType: String {
    case COMMENT = "Comment"
    case IMAGE = "Image"
}
