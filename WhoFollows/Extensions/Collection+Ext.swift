//
//  Collection+Ext.swift
//  WhoFollows
//
//  Created by Maks Winters on 05.03.2025.
//

extension Collection where Element == FollowerEntity {
    func convertToFollowers() -> [Follower] {
        compactMap(\.convertToFollower)
    }
}
