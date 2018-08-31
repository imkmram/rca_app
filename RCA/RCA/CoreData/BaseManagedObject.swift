//
//  BaseManagedObject.swift
//  RCA
//
//  Created by Ashok Gupta on 29/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import CoreData

class BaseManagedObject: NSManagedObject {
    
    func selectAllFrom<T: BaseManagedObject>(entityName: String) ->[T] {
        
        var list: [T] = []
        
        let request =  NSFetchRequest<T>(entityName: entityName)
        
        let service = BaseCoreService()
        
        do {
            list = try service.managedObjectContext.fetch(request)
            
        } catch { }
        
        return list
    }
    
    func deleteAllFrom(entityName: String) -> Bool {

        var list: [BaseManagedObject] = []
        let request =  NSFetchRequest<BaseManagedObject>(entityName: entityName)

        let service = BaseCoreService()

        do {
            list = try service.managedObjectContext.fetch(request)
            
            for row in list {
                service.managedObjectContext.delete(row)
            }
            do {
               try service.managedObjectContext.save()
                 return true
            }
            catch { }

        } catch { }
      
        return false
    }
}

