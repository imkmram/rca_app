//
//  TripTabVC.swift
//  weRide
//
//  Created by Ashok Gupta on 24/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

struct RideData {
    var ownerID : String?
    var ownerName : String?
    var userID : String?
    var userName : String?
    var userEmailID : String?
    var mobileNo : String?
    var rideID : String?
    var rideName : String?
    var rideDesc : String?
    var startDate : String?
    var startTime : String?
    var endDate : String?
    var endTime : String?
    var maxRider : String?
    var image : String?
    var rideType : VehicleType!
    var startDateTimeDisplay: String?
    var endDateTimeDisplay: String?
    var rideImage: String?
}

class TripTabVC: UITabBarController {
    
    var screenFor: Screen = Screen.DEFAULT
    var participantType: ParticipantType!
    
    var responseData: Result_set?
    var participants: [Participants] = []
    
    var rideData = RideData()
    var action: ActionType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = responseData {
            
            rideData.userID = data.user_id
            rideData.userName = data.user_name
            rideData.userEmailID = data.user_email_id
            rideData.rideID = data.ride_id
            rideData.rideName = data.ride_name
            rideData.rideDesc = data.ride_desc
            
            rideData.startDate = data.ride_date_from
            rideData.endDate = data.ride_date_to
            rideData.startTime = data.ride_time_from
            rideData.endTime = data.ride_time_to
            rideData.maxRider = data.ride_participant_limit
            rideData.ownerID = data.owner_id
            rideData.ownerName = data.owner_name
            rideData.rideImage = data.ride_image
            
            if let startDate = data.ride_date_from, let startTime = data.ride_time_from {
                 rideData.startDateTimeDisplay = createDateForDisplay(strDate: startDate + " " +  startTime)
            }
            
            if let endDate = data.ride_date_to, let endTime = data.ride_time_to {
                rideData.endDateTimeDisplay = createDateForDisplay(strDate: endDate + " " + endTime)
            }
            
            if data.ride_type == "Car" {
                rideData.rideType = VehicleType.Car
            }
            else if data.ride_type == "Bike" {
                rideData.rideType = VehicleType.Bike
            }
            else {
                rideData.rideType = VehicleType.Other
            }
            
            if data.owner_id == UserDefaults.standard.getUserID() {
                participantType = ParticipantType.OWNER
            }
            else {
                participantType = ParticipantType.CO_RIDER
            }
            
            if let list = data.participants {
                participants = list
            }
        }
        else {
           //participantType = ParticipantType.CO_RIDER
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
       // self.navigationController?.navigationBar.tintColor = UIColor(named: "BaseColor")
    }

    func createDateForDisplay(strDate:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
        
        guard let date =  dateFormatter.date(from: strDate) else {
            return ""
        }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd-MMM-yyyy hh:mm a"
        
        return displayFormatter.string(from: date)
    }
    
   override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

    switch item.tag {
    case 0:
       //  self.navigationController?.navigationBar.isHidden = false
        break
    case 1:
         //self.navigationController?.navigationBar.isHidden = false
        break
    case 2:
        // self.navigationController?.navigationBar.isHidden = true
        break
    default:
        break
    }
        
    }
}

