/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct Mna_airports : Codable, ServiceModel {
    
    var title: String?
    var product_type: String?
    var product_id: String?
    var airport: String?
    var airport_code: String?
    var country: String?
    var country_code: String?
    var city: String?

	enum CodingKeys: String, CodingKey {

		case airport = "airport"
		case airport_code = "airport_code"
		case country = "country"
		case country_code = "country_code"
		case city = "city"
		case product_id = "product_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		airport = try values.decodeIfPresent(String.self, forKey: .airport)
		airport_code = try values.decodeIfPresent(String.self, forKey: .airport_code)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		product_id = try values.decodeIfPresent(String.self, forKey: .product_id)
        title = try values.decodeIfPresent(String.self, forKey: .airport)
	}

}
