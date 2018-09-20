/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/


import Foundation

struct Result_set : Codable {
	
    let service_list : [ServiceData]?
    let mna_product_list : [MnA_ProductData]?
    let lounge_product_list : [MnA_ProductData]?

	enum CodingKeys: String, CodingKey {

        case service_list = "service_list"
        case mna_product_list = "mna_products_list"
        case lounge_product_list = "lounge_products_list"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		
        service_list = try values.decodeIfPresent([ServiceData].self, forKey: .service_list)
        mna_product_list = try values.decodeIfPresent([MnA_ProductData].self, forKey: .mna_product_list)
         lounge_product_list = try values.decodeIfPresent([MnA_ProductData].self, forKey: .lounge_product_list)
	}
}
