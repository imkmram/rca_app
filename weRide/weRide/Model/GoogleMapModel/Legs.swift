/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Legs : Codable {
	let distance : Distance?
	let duration : Duration?
	let end_address : String?
	let end_location : End_location?
	let start_address : String?
	let start_location : Start_location?
	let steps : [Steps]?
	let traffic_speed_entry : [String]?
	let via_waypoint : [String]?

	enum CodingKeys: String, CodingKey {

		case distance = "distance"
		case duration = "duration"
		case end_address = "end_address"
		case end_location = "end_location"
		case start_address = "start_address"
		case start_location = "start_location"
		case steps = "steps"
		case traffic_speed_entry = "traffic_speed_entry"
		case via_waypoint = "via_waypoint"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		distance = try values.decodeIfPresent(Distance.self, forKey: .distance)
		duration = try values.decodeIfPresent(Duration.self, forKey: .duration)
		end_address = try values.decodeIfPresent(String.self, forKey: .end_address)
		end_location = try values.decodeIfPresent(End_location.self, forKey: .end_location)
		start_address = try values.decodeIfPresent(String.self, forKey: .start_address)
		start_location = try values.decodeIfPresent(Start_location.self, forKey: .start_location)
		steps = try values.decodeIfPresent([Steps].self, forKey: .steps)
		traffic_speed_entry = try values.decodeIfPresent([String].self, forKey: .traffic_speed_entry)
		via_waypoint = try values.decodeIfPresent([String].self, forKey: .via_waypoint)
	}

}