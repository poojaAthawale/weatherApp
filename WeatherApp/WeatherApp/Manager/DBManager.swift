//
//  DBManager.swift
//  WeatherApp
//
//  Created by pooja  on 14/07/21.
//

import Foundation

import UIKit
import CoreData

class DBManager: NSObject {
    
    fileprivate static var sharedInstanceValue: DBManager!
    
    static func sharedInstance() -> DBManager {
        if sharedInstanceValue == nil {
            sharedInstanceValue = DBManager()
        }
        return sharedInstanceValue
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "WeatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
}
