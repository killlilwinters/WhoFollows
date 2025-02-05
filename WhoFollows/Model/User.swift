//
//  User.swift
//  WhoFollows
//
//  Created by Maks Winters on 05.02.2025.
//

struct User: Codable {
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let name: String?
    let bio: String?
    let followers: Int
    let following: Int
    let createdAt: String
    let location: String?
    let publicRepos: Int
    let publicGists: Int
}
