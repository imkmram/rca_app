//
//  ServiceCD+CoreDataClass.swift
//  RCA
//
//  Created by Ashok Gupta on 07/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ServiceCD)
class ServiceCD: BaseManagedObject {
    
    class func save(list: [Service_list]) {
        
        let coreDataService = BaseCoreService.shared
        
        let context = coreDataService.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "ServiceCD", in: context)
        
        for data in list {
            
            let serviceCD = ServiceCD(entity: entity!, insertInto: context)
            
            serviceCD.airport = data.airport
            serviceCD.airport_code = data.airport_code
            serviceCD.city = data.city
            serviceCD.country = data.country
            serviceCD.country_code = data.country_code
            serviceCD.product_id = data.product_id
            serviceCD.product_type = data.product_type
            
            if data.product_id == "1" {
                serviceCD.title = data.product_type
            }
            else {
                serviceCD.title = data.airport
            }
            
            coreDataService.saveContext()
        }
    }
    
    func selectAll(entityName: String) ->[ServiceCD] {
        
        var list: [ServiceCD] = []
        
        let request =  NSFetchRequest<ServiceCD>(entityName: "ServiceCD")
        
        let service = BaseCoreService.shared
        
        do {
            list = try service.managedObjectContext.fetch(request)
            
        } catch { }
        
        return list
    }
    
    func selectByProductID(productID: String) -> [ServiceCD] {
        
        var list: [ServiceCD] = []
        
        let request =  NSFetchRequest<ServiceCD>(entityName: "ServiceCD")
        request.predicate = NSPredicate(format: "product_id = %@", productID)
        
        let service = BaseCoreService.shared
        
        do {
            list = try service.managedObjectContext.fetch(request)
            
        } catch { }
        
        
        return list
    }
}
