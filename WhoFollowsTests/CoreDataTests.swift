//
//  WhoFTest.swift
//  CoreDataTests
//
//  Created by Maks Winters on 03.03.2025.
//

import XCTest
import CoreData
@testable import WhoFollows

let follower = Follower(login: "killlilwinters", avatarUrl: "https://avatars.githubusercontent.com/u/139014119?v=4")

final class CoreDataTests: XCTestCase {
    
    var coreDataController: CoreDataController!
    
    override func setUp() {
        super.setUp()
        coreDataController = CoreDataController.testingInstance
    }
    
    override func tearDown() {
        coreDataController.context.reset()
        FileManager.clearCache()
        super.tearDown()
    }

}

// MARK: - CoreData tests
extension CoreDataTests {
    
    func test_addFollower() {
        let context = coreDataController.context
        
        // Prepare image
        let avatarImageView = WFAvatarImageView(frame: .zero)
        avatarImageView.downloadImage(from: follower.avatarUrl)
        let image = avatarImageView.image!
        
        // Run tested method
        do {
            try coreDataController.addFollower(follower, image: image)
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

}
