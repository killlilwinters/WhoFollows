//
//  FollowerEntity+CoreDataClass.swift
//  WhoFollows
//
//  Created by Maks Winters on 02.03.2025.
//
//

import Foundation
import CoreData

@objc(FollowerEntity)
public class FollowerEntity: NSManagedObject {
    
    var convertToFollower: Follower? {
        guard let login = login, let avatarURL = avatarURL else { return nil }
        return Follower(login: login, avatarUrl: avatarURL)
    }
    
}
