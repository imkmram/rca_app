//
//  PassportType+CoreDataProperties.swift
//  RCA
//
//  Created by TWC on 30/07/18.
//  Copyright © 2018 TWC. All rights reserved.
//
//

import Foundation
import CoreData


extension PassportType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PassportType> {
        return NSFetchRequest<PassportType>(entityName: "PassportType")
    }

    @NSManaged public var type_code: String?
    @NSManaged public var type_name: String?
    @NSManaged public var type_id: Int32

}
