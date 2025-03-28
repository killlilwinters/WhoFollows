//
//  Constants.swift
//  WhoFollows
//
//  Created by Maks Winters on 20.02.2025.
//

import UIKit
/// swiftlint:disable line_length

typealias TableViewDelegateMethods = UITableViewDelegate & UITableViewDataSource
// MARK: - Enums
enum WFSymbols {
    case locationMarkIcon
    case followersCountIcon
    case followingCountIcon
    case repositoriesIcon
    case gistsIcon
    
    case shareIcon
    case safariIcon
    
    case addIcon
    case checkmarkIcon

    var image: UIImage {
        switch self {
        case .locationMarkIcon:
            return UIImage(systemName: "mappin.and.ellipse.circle")!
        case .followersCountIcon:
            return UIImage(systemName: "person.2.fill")!
        case .followingCountIcon:
            return UIImage(systemName: "person.crop.circle")!
        case .repositoriesIcon:
            return UIImage(systemName: "square.3.layers.3d.down.backward")!
        case .gistsIcon:
            return UIImage(systemName: "text.alignleft")!
        case .shareIcon:
            return UIImage(systemName: "square.and.arrow.up")!
        case .safariIcon:
            return UIImage(systemName: "safari")!
        case .addIcon:
            return UIImage(systemName: "plus")!
        case .checkmarkIcon:
            return UIImage(systemName: "checkmark")!
        }
    }
}

enum WFAlertTitleMessages: String {
    case somethingWentWrong = "Something went wrong..."
    case userExists = "User already exists"
    case invalidURL = "Invalid URL"
}

// MARK: - Preview constants
let killlilwinters = User(
    login: "killlilwinters",
    avatarUrl: "https://avatars.githubusercontent.com/u/139014119?v=4",
    htmlUrl: "https://github.com/killlilwinters",
    name: "Max Winters",
    bio: "👨‍💻 " + String.init(repeating: "Swift ", count: 20) + "👨‍💻",
    followers: 24125,
    following: 13,
    createdAt: Date(),
    location: "Kharkiv, Ukraine",
    publicRepos: 39,
    publicGists: 0
)
let userInfoPieceExample = UserTileData(
    title: "Repositories",
    subtitle: "View more...",
    icon: .repositoriesIcon,
    value: "53"
)

/// swiftlint:enable line_length
