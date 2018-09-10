//
//  ServiceCD+CoreDataProperties.swift
//  RCA
//
//  Created by Ashok Gupta on 07/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//
//

import Foundation
import CoreData


extension ServiceCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ServiceCD> {
        return NSFetchRequest<ServiceCD>(entityName: "ServiceCD")
    }

    @NSManaged public var product_type: String?
    @NSManaged public var product_id: String?
    @NSManaged public var airport: String?
    @NSManaged public var airport_code: String?
    @NSManaged public var country: String?
    @NSManaged public var country_code: String?
    @NSManaged public var city: String?
     @NSManaged public var title: String?

}
