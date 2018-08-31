//
//  BaseCoreService.swift
//  RCA
//
//  Created by TWC on 30/07/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit
import CoreData

class BaseCoreService {
    
   private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelUrl = Bundle.main.url(forResource: "RCA", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelUrl)!
    }()
    
   private lazy var peristentStoreCoordinator: NSPersistentStoreCoordinator = {
    
        let coordinator: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let applicationDocumentsDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let persistentStoreUrl: URL = applicationDocumentsDirectory.appendingPathComponent("RCA.sqlite")
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreUrl, options: nil)
        }
        catch {
            fatalError("Persistent store error! \(error)")
        }
        
        return coordinator
    }()
    
   lazy var managedObjectContext: NSManagedObjectContext = {
        
        let managedObjectContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.peristentStoreCoordinator
        
        return managedObjectContext
    }()
    
    func saveContext() {
        if self.managedObjectContext.hasChanges {
            do {
                try self.managedObjectContext.save()
            }
            catch {
                fatalError("There was an error saving the managed object context \(error)")
            }
        }
    }
}
