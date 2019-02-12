//
//  Utils.swift
//  weRide
//
//  Created by Ashok Gupta on 24/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import Foundation
import UIKit

struct Utils {
    
    static func mainStoryboardController(identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: Constant.STORYBOARD_Main, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func tripStoryboardController(identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: Constant.STORYBOARD_Trip, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func startRideStoryboardController(identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: Constant.STORYBOARD_StartRide, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func loginStoryboardController(identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: Constant.STORYBOARD_Login, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func profileStoryboardController(identifier: String) -> UIViewController {
        
        let storyboard = UIStoryboard(name: Constant.STORYBOARD_Profile, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func dateToString(date: Date) -> (strDate:String, strTime: String, strDateTime: String) {
        let format = "yyyy-MM-dd"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        let str_date = dateFormatter.string(from: date)
        
        let timeFormat = "HH:mm a"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = timeFormat
        
        let str_time = timeFormatter.string(from: date)
        
        let displayFormat = "dd-MMM-yyyy h:mm a"
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = displayFormat
        
        let str_dateTime = displayFormatter.string(from: date)
        
        return (str_date, str_time, str_dateTime)
    }
    
    static func stringToDate(strDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
        
        guard let date =  dateFormatter.date(from: strDate) else {
            return nil
        }
        return date
    }
    
    private static func getLocation(list:[Waypoints]) -> (startLocation: Waypoints, endLocation: Waypoints, wayPointsLocation: [Waypoints]? ) {
        
        var origin: Waypoints!
        var destination: Waypoints!
        var waypoints: [Waypoints]?
        
        if list.count == 2 {
            origin = list.first
            destination = list.last
        }
        else if list.count > 2 {
            origin = list.first
            destination = list.last
            
            waypoints = []
            
            for i in 1..<list.count - 1 {
                waypoints?.append(list[i])
            }
        }
        return (origin, destination, waypoints)
    }
    
    static func googleMapURL(callType: GOOGLE_CallType!, list: [Waypoints]) -> String {
        var baseURL: String = ""
        
        switch callType! {
        case .ROUTE:
          baseURL = Constant.kGOOGLE_ROUTE_API
        case .DIRECTION:
           baseURL = Constant.kGOOGLE_DIRECTION
        }
        let key: String = "&key=\(Constant.kGOOGLE_KEY)"
        var strURL: String = ""
        
        let result = getLocation(list: list)
        
        let origin: String = "origin=\(result.startLocation.waypoint_latitude ?? ""),\(result.startLocation.waypoint_longitude ?? "")"
        var destination: String = "&destination=\(result.endLocation.waypoint_latitude ?? ""),\(result.endLocation.waypoint_longitude ?? "")"
        
      destination =  destination.appending("&z=20")
        
        if result.wayPointsLocation == nil {
            strURL = baseURL.appending(origin).appending(destination).appending(key)
        }
        else {
            var waypoints: String = "&waypoints="
            for coordinate in result.wayPointsLocation! {
                waypoints = waypoints.appending("\(coordinate.waypoint_latitude ?? ""),\(coordinate.waypoint_longitude ?? "")|")
            }
            waypoints.removeLast()
            waypoints = waypoints.replacingOccurrences(of: "|", with: "%7C")
         //   waypoints.appending("&zoom=20&views=traffic")
            strURL = baseURL.appending(origin).appending(destination).appending(waypoints).appending(key)
        }
        
        return strURL
    }
    
}
