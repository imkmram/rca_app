/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Routes : Codable {
	let bounds : Bounds?
	let copyrights : String?
	let legs : [Legs]?
	let overview_polyline : Overview_polyline?
	let summary : String?
	let warnings : [String]?
	let waypoint_order : [Int]?

	enum CodingKeys: String, CodingKey {

		case bounds = "bounds"
		case copyrights = "copyrights"
		case legs = "legs"
		case overview_polyline = "overview_polyline"
		case summary = "summary"
		case warnings = "warnings"
		case waypoint_order = "waypoint_order"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		bounds = try values.decodeIfPresent(Bounds.self, forKey: .bounds)
		copyrights = try values.decodeIfPresent(String.self, forKey: .copyrights)
		legs = try values.decodeIfPresent([Legs].self, forKey: .legs)
		overview_polyline = try values.decodeIfPresent(Overview_polyline.self, forKey: .overview_polyline)
		summary = try values.decodeIfPresent(String.self, forKey: .summary)
		warnings = try values.decodeIfPresent([String].self, forKey: .warnings)
		waypoint_order = try values.decodeIfPresent([Int].self, forKey: .waypoint_order)
	}

}