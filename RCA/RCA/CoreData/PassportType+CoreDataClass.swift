//
//  PassportType+CoreDataClass.swift
//  RCA
//
//  Created by TWC on 30/07/18.
//  Copyright © 2018 TWC. All rights reserved.
//
//

import Foundation
import CoreData


@objc(PassportType)
public class PassportType: NSManagedObject {

    func getAllDataFromBD() ->[PassportType] {
        
        var list:[PassportType] = [PassportType]()
        
        let request:NSFetchRequest<PassportType> = PassportType.fetchRequest()
        let service = BaseCoreService()
        
        do {
             list = try service.managedObjectContext.fetch(request)
            
        } catch {
            
        }
        return list
    }
}
