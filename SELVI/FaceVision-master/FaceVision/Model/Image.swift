//
//  SavedImage.swift
//  FaceVision
//
//  Created by Ashok Gupta on 07/02/19.
//  Copyright © 2019 IntelligentBee. All rights reserved.
//

import Foundation
import UIKit

struct Image : Codable {
    
    var doc_id : Int?
    var doc_name : String?
    var doc_size : String?
    var image_identifier : String?
    var image: Data?
    
    enum CodingKeys: String, CodingKey {
        
        case doc_id = "doc_id"
        case doc_name = "doc_name"
        case doc_size = "doc_size"
        case image_identifier = "image_identifier"
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        doc_id = try values.decodeIfPresent(Int.self, forKey: .doc_id)
        doc_name = try values.decodeIfPresent(String.self, forKey: .doc_name)
        doc_size = try values.decodeIfPresent(String.self, forKey: .doc_size)
        image_identifier = try values.decodeIfPresent(String.self, forKey: .image_identifier)
        image = try  values.decodeIfPresent(Data.self, forKey: .image)
    }
    
    init(doc_id: Int?, doc_name: String?, doc_size: String, image_identifier: String?) {
        self.doc_id = doc_id
        self.doc_name = doc_name
        self.doc_size = doc_size
        self.image_identifier = image_identifier
    }
}
