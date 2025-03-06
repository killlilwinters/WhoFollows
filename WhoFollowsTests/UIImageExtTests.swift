//
//  UIImageExtTests.swift
//  WhoFollowsTests
//
//  Created by Maks Winters on 04.03.2025.
//

import XCTest
@testable import WhoFollows

final class UIImageExtTests: XCTestCase {
    
    static let cacheDirectoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    
    static let writePNGToStorage: () -> (UIImage, Data, URL) = {
        
        let uiImage = UIImage(resource: .avatarPlaceholder)
        /// **Make sure to use jpeg resource image when getting jpegData. Same goes for .pngData!**
        let imageData = uiImage.pngData()
        
        // Prepare URL
        let imageURL = cacheDirectoryURL.appendingPathComponent(follower.login)
        
        // Save image to URL
        try? imageData?.write(to: imageURL)
        
        return (
            uiImage: uiImage,
            data: imageData!,
            imageURL: imageURL
        )
        
    }
    
    override func setUp() {
        FileManager.clearCache()
    }
    
}

// MARK: - Tests
extension UIImageExtTests {
    
    func test_saveToDisk() {
        
        let uiImage = UIImage(resource: .avatarPlaceholder)
        let uiImageDataHashed = uiImage.pngData()?.hashValue ?? 0
        
        do {
            
            let imageURL = try uiImage.saveToDisk(follower: follower)
            
            guard let returnImage = UIImage(contentsOfFile: imageURL!) else {
                return XCTFail("Failed to get image contents")
            }
            
            let returnImageDataHashed = returnImage.pngData()?.hashValue
            
            XCTAssertEqual(uiImageDataHashed, returnImageDataHashed)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func test_getFromDisk() {
        // Prepare image
        let (_, imageData, _) = UIImageExtTests.writePNGToStorage()
        
        // Test
        guard let recoveredImage = try? UIImage.getFromDisk(login: follower.login) else {
            return XCTFail("Failed to recover the image")
        }
        /// **Use .pngData when testing the equality of two images, since jpeg is a lossy format
        /// which will result in different data on each compession run**
        let recoveredImageData = recoveredImage.pngData()
        /// **Use hashValues to compare for equality,
        /// otherwise
        /// XCTAssertEqual failed: ("34375 bytes") is not equal to ("34375 bytes")
        XCTAssertEqual(imageData.hashValue, recoveredImageData?.hashValue)
    }
    
    func test_removeFromDisk() {
        // Prepare Image
        let (_, imageData, imageURL) = UIImageExtTests.writePNGToStorage()
        
        // Write data to disk
        do {
            try imageData.write(to: imageURL)
        } catch {
            print(error.localizedDescription)
        }
        
        // Run tested method
        do {
            try UIImage.removeFromDisk(login: follower.login)
        } catch {
            print(error.localizedDescription)
        }
        
        // Assert
        let doesFileExist = FileManager.default.fileExists(atPath: imageURL.path)
        XCTAssertEqual(doesFileExist, false)
       
    }
    
}
