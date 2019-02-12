//
//  Gallery.swift
//  FaceVision
//
//  Created by Ashok Gupta on 07/02/19.
//  Copyright © 2019 IntelligentBee. All rights reserved.
//

import Foundation

struct Gallery : Codable {
    
    var images : [Image]?
    
    enum CodingKeys: String, CodingKey {
        
        case images = "images"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        images = try values.decodeIfPresent([Image].self, forKey: .images)
    }
    
    init(list:[Image]) {
        self.images = list
    }
}
