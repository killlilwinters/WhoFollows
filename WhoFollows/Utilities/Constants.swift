//
//  Constants.swift
//  WhoFollows
//
//  Created by Maks Winters on 20.02.2025.
//
import UIKit
// swiftlint:disable line_length

typealias SearchControllerMethods = UISearchResultsUpdating & UISearchBarDelegate
// MARK: - Enums
enum SFSymbols {
    static let locationMark = "mappin.and.ellipse.circle"
}
// MARK: - Preview constants
let killlilwinters = User(
    login: "killlilwinters",
    avatarUrl: "https://avatars.githubusercontent.com/u/139014119?v=4",
    htmlUrl: "https://github.com/killlilwinters",
    name: "Max Winters",
    bio: "👨‍💻 " + String.init(repeating: "Swift ", count: 20) + "👨‍💻",
    followers: 2,
    following: 13,
    createdAt: "2023-07-08T20:37:26Z",
    location: "Kharkiv, Ukraine",
    publicRepos: 39,
    publicGists: 0
)
let userInfoPiece = UserInfoPiece(
    icon: UIImage(systemName: "square.3.layers.3d.down.backward"),
    value: "53",
    title: "Repositories",
    subtitle: "View more..."
)

// swiftlint:enable line_length
