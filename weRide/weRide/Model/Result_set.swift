/* 
 Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar
 
 */

import Foundation
import GoogleMaps

struct Result_set : Codable {
    var user_id : String?
    var user_name : String?
    var user_email_id : String?
    var user_mobile_no : String?
    var user_profile_pic : String?
    
    var ride_id : String?
    var ride_name : String?
    var ride_desc : String?
    var ride_date_from : String?
    var ride_time_from : String?
    var ride_date_to : String?
    var ride_time_to : String?
    var ride_participant_limit : String?
    var ride_image : String?
    var ride_type : String?
    
    var owner_id : String?
    var owner_name : String?
    
    var participants : [Participants]?
    
    var way_point_id: String?
        var waypoint_latitude: String?
        var waypoint_location_name: String?
        var waypoint_longitude: String?
    
    var coordinate: CLLocationCoordinate2D?
    
    var waypoints : [Waypoints]?
    
    var vehicle_id: String?
    var vehicle_type: String?
    var registration_no: String?
    var manufacturer: String?
    var year: String?
    var color: String?
    var engine_capacity: String?
    var chassis_no: String?
    var insurer: String?
    var expiry: String?
    var insured_sum: String?
    
    var contact_id: String?
    var contact_name: String?
    var contact_no: String?
    
    var participantType: ParticipantType!
    
    
    enum CodingKeys: String, CodingKey {
        
        case user_id = "user_id"
        case user_name = "user_name"
        case user_email_id = "user_email_id"
        case user_mobile_no = "user_mobile_no"
        case user_profile_pic = "user_profile_pic"
        
        case ride_id = "ride_id"
        case ride_name = "ride_name"
        case ride_desc = "ride_desc"
        case ride_date_from = "ride_date_from"
        case ride_time_from = "ride_time_from"
        case ride_date_to = "ride_date_to"
        case ride_time_to = "ride_time_to"
        case ride_participant_limit = "ride_participant_limit"
        case ride_image = "ride_image"
        case ride_type = "ride_type"
        
        case owner_id = "owner_id"
        case owner_name = "owner_name"
        case participants = "participants"
        
        case way_point_id = "way_point_id"
                case waypoint_latitude = "waypoint_latitude"
                case waypoint_location_name = "waypoint_location_name"
                case waypoint_longitude = "waypoint_longitude"
        
        case waypoints = "waypoints"
        
        case vehicle_id = "vehicle_id"
        case vehicle_type = "vehicle_type"
        case registration_no = "registration_no"
        case manufacturer = "manufacturer"
        case color =   "colour"
        case year =  "year"
        case engine_capacity = "engine_capacity"
        case chassis_no = "chasis_no"
        case insurer = "insurer"
        case expiry = "expiry"
        case insured_sum = "insured_sum"
        
        
        case contact_id = "ec_id"
        case contact_name = "ec_contact_name"
        case contact_no =  "ec_contact_no"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        user_name = try values.decodeIfPresent(String.self, forKey: .user_name)
        user_email_id = try values.decodeIfPresent(String.self, forKey: .user_email_id)
        user_mobile_no = try values.decodeIfPresent(String.self, forKey: .user_mobile_no)
        user_profile_pic = try values.decodeIfPresent(String.self, forKey: .user_profile_pic)
        
        ride_id = try values.decodeIfPresent(String.self, forKey: .ride_id)
        ride_name = try values.decodeIfPresent(String.self, forKey: .ride_name)
        ride_desc = try values.decodeIfPresent(String.self, forKey: .ride_desc)
        ride_date_from = try values.decodeIfPresent(String.self, forKey: .ride_date_from)
        ride_time_from = try values.decodeIfPresent(String.self, forKey: .ride_time_from)
        ride_date_to = try values.decodeIfPresent(String.self, forKey: .ride_date_to)
        ride_time_to = try values.decodeIfPresent(String.self, forKey: .ride_time_to)
        ride_participant_limit = try values.decodeIfPresent(String.self, forKey: .ride_participant_limit)
        ride_image = try values.decodeIfPresent(String.self, forKey: .ride_image)
        ride_type = try values.decodeIfPresent(String.self, forKey: .ride_type)
        owner_id = try values.decodeIfPresent(String.self, forKey: .owner_id)
        owner_name = try values.decodeIfPresent(String.self, forKey: .owner_name)
        
        participants = try values.decodeIfPresent([Participants].self, forKey: .participants)
        
        way_point_id = try values.decodeIfPresent(String.self, forKey: .way_point_id)
                  waypoint_latitude = try values.decodeIfPresent(String.self, forKey: .waypoint_latitude)
                  waypoint_location_name = try values.decodeIfPresent(String.self, forKey: .waypoint_location_name)
                  waypoint_longitude = try values.decodeIfPresent(String.self, forKey: .waypoint_longitude)
        
        waypoints = try values.decodeIfPresent([Waypoints].self, forKey: .waypoints)
        vehicle_id = try values.decodeIfPresent(String.self, forKey: .vehicle_id)
        vehicle_type = try values.decodeIfPresent(String.self, forKey: .vehicle_type)
        registration_no = try values.decodeIfPresent(String.self, forKey: .registration_no)
        manufacturer = try values.decodeIfPresent(String.self, forKey: .manufacturer)
        year = try values.decodeIfPresent(String.self, forKey: .year)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        
        engine_capacity = try values.decodeIfPresent(String.self, forKey: .engine_capacity)
        chassis_no = try values.decodeIfPresent(String.self, forKey: .chassis_no)
        insurer = try values.decodeIfPresent(String.self, forKey: .insurer)
        expiry = try values.decodeIfPresent(String.self, forKey: .expiry)
        insured_sum = try values.decodeIfPresent(String.self, forKey: .insured_sum)
        
        
        contact_id = try values.decodeIfPresent(String.self, forKey: .contact_id)
        contact_name = try values.decodeIfPresent(String.self, forKey: .contact_name)
        contact_no = try values.decodeIfPresent(String.self, forKey: .contact_no)
    }
    
    init() {
        
    }
}
