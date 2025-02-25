//
//  Constants.swift
//  WhoFollows
//
//  Created by Maks Winters on 20.02.2025.
//
import UIKit
/// swiftlint:disable line_length

typealias SearchControllerMethods = UISearchResultsUpdating & UISearchBarDelegate
// MARK: - Enums
enum WFSymbols {
    case locationMarkIcon
    case followersCountIcon
    case followingCountIcon
    case repositoriesIcon

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
        }
    }
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
    createdAt: "2023-07-08T20:37:26Z",
    location: "Kharkiv, Ukraine",
    publicRepos: 39,
    publicGists: 0
)
let userInfoPieceExample = UserInfoPiece(
    title: "Repositories",
    icon: .repositoriesIcon,
    value: "53",
    subtitle: "View more..."
)

/// swiftlint:enable line_length
