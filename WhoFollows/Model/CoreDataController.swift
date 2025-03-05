//
//  CoreDataController.swift
//  WhoFollows
//
//  Created by Maks Winters on 02.03.2025.
//

import Foundation
import CoreData
import UIKit

enum CoreDataError: LocalizedError {
    case followerNotFound
    case invalidFollowerData
    
    var errorDescription: String? {
        switch self {
        case .followerNotFound:
            return "Follower not found."
        case .invalidFollowerData:
            return "The follower data is invalid."
        }
    }
}

class CoreDataController {

    static let shared = CoreDataController()
    static var testingInstance: CoreDataController = {
        return .init(inMemory: true)
    }()

    // Persistent container for Core Data
    private let persistentContainer: NSPersistentContainer

    // Managed Object Context
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private init(inMemory: Bool = false) {
        // Initialize persistent container
        persistentContainer = NSPersistentContainer(name: "WhoFollows")
        
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

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

// MARK: - Public methods
extension CoreDataController {
    
    func fetchAllFollowers() throws -> [FollowerEntity] {
        let fetchRequest: NSFetchRequest<FollowerEntity> = FollowerEntity.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            throw error
        }
    }
    
    func getFollower(login: String) throws -> Follower {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FollowerEntity")
        let predicate = NSPredicate(format: "login == %@", login)
        
        fetchRequest.predicate = predicate
        
        do {
            let fetchResult = try context.fetch(fetchRequest) as? [FollowerEntity]
            guard let followerEntity = fetchResult?.first else { throw CoreDataError.followerNotFound }
            
            guard let convertedFollower = followerEntity.convertToFollower else {
                throw CoreDataError.invalidFollowerData
            }
            
            return convertedFollower
            
        } catch {
            throw error
        }
    }
    
    func addFollower(_ follower: Follower, image: UIImage) throws {
        let newFollower = FollowerEntity(context: context)
        
        newFollower.login = follower.login
        newFollower.avatarURL = follower.avatarUrl
        
        do {
            newFollower.avatarImagePath = try image.saveToDisk(follower: follower)
            try context.save()
        } catch {
            throw error
        }
        
    }
    
    func removeFollower(login: String) throws {
        do {
            let followers = try fetchAllFollowers()
            
            if let follower = followers.first(where: { $0.login == login }) {
                self.context.delete(follower)
            } else {
                throw CoreDataError.followerNotFound
            }
            
        } catch {
            throw error
        }
        
    }
    
}
