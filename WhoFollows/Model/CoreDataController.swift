//
//  CoreDataController.swift
//  WhoFollows
//
//  Created by Maks Winters on 02.03.2025.
//

import Foundation

import Foundation
import CoreData

class CoreDataController {

    static let shared = CoreDataController()

    // Persistent container for Core Data
    private let persistentContainer: NSPersistentContainer

    // Managed Object Context
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private init() {
        // Initialize persistent container
        persistentContainer = NSPersistentContainer(name: "WhoFollows")

        // Load persistent stores
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    // Save context
    func saveContext() {
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
