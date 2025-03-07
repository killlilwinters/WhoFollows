//
//  WhoFTest.swift
//  CoreDataTests
//
//  Created by Maks Winters on 03.03.2025.
//
// https://stackoverflow.com/a/77698951
//

import XCTest
import CoreData
@testable import WhoFollows

final class CoreDataTests: XCTestCase {
    
    var coreDataController: CoreDataController!
    
    override func setUp() {
        super.setUp()
        coreDataController = CoreDataController.testingInstance
        coreDataController.removeAllFollowers()
    }
    
    override func tearDown() {
        coreDataController.context.reset()
        FileManager.clearCache()
        super.tearDown()
    }

}

// MARK: - CoreData tests
extension CoreDataTests {
    
    func test_getFollower() {
        let uiImage = UIImage(resource: .avatarPlaceholder)
        try? coreDataController.addFollower(follower)
        try? uiImage.saveToDisk(follower: follower)
        
        let fetchedFollower = try? coreDataController.getFollower(login: follower.login)
        
        XCTAssertEqual(fetchedFollower, follower)
        
    }
    
    func test_addFollower() {
        let context = coreDataController.context
        
        // Prepare image
        let image = UIImage(resource: .avatarPlaceholder)
        
        // Run tested method
        do {
            try coreDataController.addFollower(follower)
            try image.saveToDisk(follower: follower)
        } catch {
            print(error.localizedDescription)
        }
        
        // Fetch
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FollowerEntity")
        let predicate = NSPredicate(format: "login == %@", follower.login)
        fetchRequest.predicate = predicate
        let fetchResult = try? context.fetch(fetchRequest) as? [FollowerEntity]
        
        // Assert
        XCTAssertEqual(fetchResult?.count, 1)
    }
    
    func test_removeFollower() {
        let uiImage = UIImage(resource: .avatarPlaceholder)
        try? coreDataController.addFollower(follower)
        try? uiImage.saveToDisk(follower: follower)
        
        let savedFollower = try? coreDataController.getFollower(login: follower.login)
        guard savedFollower != nil else {
            return XCTFail("There was an error with getting the follower.")
        }
        
        try? coreDataController.removeFollower(login: follower.login)

        XCTAssertNil(try? coreDataController.getFollower(login: follower.login))
    }
    
    func test_fetchAllFollowers() {
        let uiImage = UIImage(resource: .avatarPlaceholder)
        let firstFollower = Follower(login: "coolGuy", avatarUrl: "")
        let secondFollower = Follower(login: "anotherLogin", avatarUrl: "")
        
        do {
            try coreDataController.addFollower(firstFollower)
            try uiImage.saveToDisk(follower: firstFollower)
            try coreDataController.addFollower(secondFollower)
            try uiImage.saveToDisk(follower: secondFollower)
        } catch {
            print(error.localizedDescription)
        }
        
        let allFollowers = coreDataController.getAllFollowers()
        
        XCTAssertEqual(allFollowers.count, 2)
    }
    
}

// MARK: - Less necessary tests
extension CoreDataTests {
    
    func test_removeFollower_nonExistingFollower() {
        do {
            try coreDataController.removeFollower(login: "123")
        } catch {
            XCTAssertEqual(error as? CoreDataError, CoreDataError.followerNotFound)
        }
    }
    
    func test_fetchAllFollowers_empty() {
        XCTAssertEqual(coreDataController.getAllFollowers(), [FollowerEntity]())
    }
    
    func test_addFollower_addExisting() {
        let uiImage = UIImage(resource: .avatarPlaceholder)
        
        do {
            try coreDataController.addFollower(follower)
            try uiImage.saveToDisk(follower: follower)
            try coreDataController.addFollower(follower)
            try uiImage.saveToDisk(follower: follower)
        } catch {
            print(error.localizedDescription)
        }
        
        XCTAssertEqual(coreDataController.getAllFollowers().count, 1)
    }
    
}
