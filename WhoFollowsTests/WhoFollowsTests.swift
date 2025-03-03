//
//  WhoFollowsTests.swift
//  WhoFollowsTests
//
//  Created by Maks Winters on 03.03.2025.
//

let follower = Follower(login: "killlilwinters", avatarUrl: "https://avatars.githubusercontent.com/u/139014119?v=4")

import XCTest
@testable import WhoFollows

final class WhoFollowsTests: XCTestCase {
    
    var coreDataController: CoreDataController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    override func setUp() {
        super.setUp()
        coreDataController = CoreDataController.testingInstance
    }
    
    override func tearDown() {
        coreDataController.context.reset()
        UIImage.clearCache()
        super.tearDown()
    }

}

// MARK: - CoreData tests
extension WhoFollowsTests {
    
    func testAddingFollower() {
        let context = coreDataController.context
        
        // prepare image
        let avatarImageView = WFAvatarImageView(frame: .zero)
        avatarImageView.downloadImage(from: follower.avatarUrl)
        let image = avatarImageView.image!
        
        // setup follower entity
        let followerEntity = FollowerEntity(context: context)
        followerEntity.login = "killlilwinters"
        followerEntity.imagePath = try? image.saveToDisk(follower: follower)
        
        // Assert
        XCTAssertEqual(try? context.fetch(FollowerEntity.fetchRequest()).count, 1)
    }

}

// MARK: UIImage tests
extension WhoFollowsTests {
    
    func testImageToDisk() {
        let uiImage = UIImage(resource: .avatarPlaceholder)
        
        do {
            
            let imageURL = try uiImage.saveToDisk(follower: follower)
            
            guard let returnImage = UIImage(contentsOfFile: imageURL!) else {
                return XCTFail("Failed to get image contents")
            }
            
            XCTAssertEqual(uiImage, returnImage)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func testImageFromDisk() {
        // Prepare image
        let uiImage = UIImage(resource: .avatarPlaceholder)
        /// **Make sure to use jpeg resource image when getting jpegData. Same goes for .pngData!**
        let imageData = uiImage.pngData()
        
        // Prepare URL
        let cacheDirectoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let imageURL = cacheDirectoryURL.appendingPathComponent("testCar")
        
        // Save image to URL
        try? imageData?.write(to: imageURL)
        
        // Test
        guard let recoveredImage = UIImage.getFromDisk(fileName: "testCar") else {
            return XCTFail("Failed to recover the image")
        }
        /// **Use .pngData when testing the equality of two images, since jpeg is a lossy format
        /// which will result in different data on each compession run**
        let recoveredImageData = recoveredImage.pngData()
        /// **Use hashValues to compare for equality,
        /// otherwise
        /// XCTAssertEqual failed: ("34375 bytes") is not equal to ("34375 bytes")
        XCTAssertEqual(imageData?.hashValue, recoveredImageData?.hashValue)
    }
    
}
