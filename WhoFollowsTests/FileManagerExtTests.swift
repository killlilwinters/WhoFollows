//
//  FileManagerExtTests.swift
//  WhoFollows
//
//  Created by Maks Winters on 04.03.2025.
//

import XCTest
@testable import WhoFollows

final class FileManagerExtTests: XCTestCase {
    
    func test_clearCache() {
        // Prepare Image in cache
        _ = UIImageExtTests.writePNGToStorage()
        
        // Run tested method
        FileManager.clearCache()
        
        // Is cache empty
        let cacheContainsItems = try? FileManager.default.contentsOfDirectory(
            at: .cachesDirectory,
            includingPropertiesForKeys: nil
        ).isEmpty
        
        XCTAssertTrue(cacheContainsItems!)
        
    }
    
}
