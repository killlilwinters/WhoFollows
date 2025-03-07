//
//  FollowerEntityTests.swift
//  WhoFollows
//
//  Created by Maks Winters on 05.03.2025.
//
import Foundation
import XCTest
@testable import WhoFollows

// MARK: - Follower entity test
extension CoreDataTests {
    func test_convertToFollower() {
        let entity = FollowerEntity(context: coreDataController.context)
        entity.login = follower.login
        entity.avatarURL = follower.avatarUrl
        
        let converted = entity.convertToFollower
        
        XCTAssertEqual(converted, follower)
    }
}
