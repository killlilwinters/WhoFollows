//
//  CoreDataError.swift
//  WhoFollows
//
//  Created by Maks Winters on 06.03.2025.
//

import Foundation

enum CoreDataError: LocalizedError, Equatable {
    case followerNotFound
    case invalidFollowerData
    case followerAlreadyExists(login: String)
    
    var errorDescription: String? {
        switch self {
        case .followerNotFound:
            return "Follower not found."
        case .invalidFollowerData:
            return "The follower data is invalid."
        case .followerAlreadyExists(let login):
            return "Follower \(login) already exists."
        }
    }
}
