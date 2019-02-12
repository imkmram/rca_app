/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Steps : Codable {
	let distance : Distance?
	let duration : Duration?
	let end_location : End_location?
	let html_instructions : String?
	let polyline : Polyline?
	let start_location : Start_location?
	let travel_mode : String?

	enum CodingKeys: String, CodingKey {

		case distance = "distance"
		case duration = "duration"
		case end_location = "end_location"
		case html_instructions = "html_instructions"
		case polyline = "polyline"
		case start_location = "start_location"
		case travel_mode = "travel_mode"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		distance = try values.decodeIfPresent(Distance.self, forKey: .distance)
		duration = try values.decodeIfPresent(Duration.self, forKey: .duration)
		end_location = try values.decodeIfPresent(End_location.self, forKey: .end_location)
		html_instructions = try values.decodeIfPresent(String.self, forKey: .html_instructions)
		polyline = try values.decodeIfPresent(Polyline.self, forKey: .polyline)
		start_location = try values.decodeIfPresent(Start_location.self, forKey: .start_location)
		travel_mode = try values.decodeIfPresent(String.self, forKey: .travel_mode)
	}

}