//
//  CoreDataError.swift
//  WhoFollows
//
//  Created by Maks Winters on 06.03.2025.
//

import Foundation

enum CoreDataError: LocalizedError {
    case followerNotFound
    case invalidFollowerData
    case followerAlreadyExists
    
    var errorDescription: String? {
        switch self {
        case .followerNotFound:
            return "Follower not found."
        case .invalidFollowerData:
            return "The follower data is invalid."
        case .followerAlreadyExists:
            return "Follower already exists."
        }
    }
}
