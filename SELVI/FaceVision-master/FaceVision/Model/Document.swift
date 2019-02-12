/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import UIKit

struct Document : Codable {
	let doc_id : Int?
	let doc_name : String?
	let size : Size?
    let doc_size : String?
    let doc_copies : Int?

	enum CodingKeys: String, CodingKey {
		case doc_id = "doc_id"
		case doc_name = "doc_name"
		case size = "size"
        case doc_size = "doc_size"
        case doc_copies = "doc_copies"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		doc_id = try values.decodeIfPresent(Int.self, forKey: .doc_id)
		doc_name = try values.decodeIfPresent(String.self, forKey: .doc_name)
		size = try values.decodeIfPresent(Size.self, forKey: .size)
        doc_size = try values.decodeIfPresent(String.self, forKey: .doc_size)
        doc_copies = try values.decodeIfPresent(Int.self, forKey: .doc_copies)
	}
}

