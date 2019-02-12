//
//  User.swift
//  FaceVision
//
//  Created by Ashok Gupta on 23/01/19.
//  Copyright © 2019 IntelligentBee. All rights reserved.
//

import Foundation
struct User : Codable {
    var user_id : Int?
    var name : String?
    var email : String?
    var password : String?
    var method : String?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case email = "email"
        case password = "password"
        case method = "method"
        case user_id = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        method = try values.decodeIfPresent(String.self, forKey: .method)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
    }
    
    init(user_id: Int?, name: String?, email: String, password: String?, method: String) {
        self.user_id = user_id
        self.name = name
        self.email = email
        self.password = password
        self.method = method
    }
}
