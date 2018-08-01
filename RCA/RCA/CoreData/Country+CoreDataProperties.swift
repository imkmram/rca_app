//
//  Country+CoreDataProperties.swift
//  RCA
//
//  Created by TWC on 01/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var country_id: Int32
    @NSManaged public var country_name: String?

}
