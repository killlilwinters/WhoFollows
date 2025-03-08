//
//  User.swift
//  WhoFollows
//
//  Created by Maks Winters on 05.02.2025.
//
import Foundation

struct User: Codable, Hashable {
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    var name: String?
    var bio: String?
    let followers: Int
    let following: Int
    let createdAt: Date
    var location: String?
    let publicRepos: Int
    let publicGists: Int
    
    func convertToFollower() -> Follower {
        Follower(login: login, avatarUrl: avatarUrl)
    }
}
