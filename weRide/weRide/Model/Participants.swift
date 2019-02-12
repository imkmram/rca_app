/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Participants : Codable {
	var participant_id : String?
	var participant_type : String?
	var user_id : String?
	var participant_status : String?
	var name : String?
	var mobileno : String?
	var email_id : String?

	enum CodingKeys: String, CodingKey {
        
		case participant_id = "participant_id"
		case participant_type = "participant_type"
		case user_id = "user_id"
		case participant_status = "participant_status"
		case name = "participant_name"
		case mobileno = "participant_mobile_no"
		case email_id = "participant_email_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		participant_id = try values.decodeIfPresent(String.self, forKey: .participant_id)
		participant_type = try values.decodeIfPresent(String.self, forKey: .participant_type)
		user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
		participant_status = try values.decodeIfPresent(String.self, forKey: .participant_status)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		mobileno = try values.decodeIfPresent(String.self, forKey: .mobileno)
		email_id = try values.decodeIfPresent(String.self, forKey: .email_id)
	}
    
    init() {
        
    }

}
