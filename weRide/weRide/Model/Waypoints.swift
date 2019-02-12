/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import GoogleMaps

struct Waypoints : Codable {
    
	var way_point_id : String?
	var ride_Id : String?
	var waypoint_location_name : String?
	var waypoint_latitude : String?
	var waypoint_longitude : String?
    var coordinate: CLLocationCoordinate2D?

	enum CodingKeys: String, CodingKey {

		case way_point_id = "way_point_id"
		case ride_Id = "ride_Id"
		case waypoint_location_name = "waypoint_location_name"
		case waypoint_latitude = "waypoint_latitude"
		case waypoint_longitude = "waypoint_longitude"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		way_point_id = try values.decodeIfPresent(String.self, forKey: .way_point_id)
		ride_Id = try values.decodeIfPresent(String.self, forKey: .ride_Id)
		waypoint_location_name = try values.decodeIfPresent(String.self, forKey: .waypoint_location_name)
		waypoint_latitude = try values.decodeIfPresent(String.self, forKey: .waypoint_latitude)
		waypoint_longitude = try values.decodeIfPresent(String.self, forKey: .waypoint_longitude)
	}
    
    init() {
    }

}
