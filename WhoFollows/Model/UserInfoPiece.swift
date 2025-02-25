//
//  UserInfoPiece.swift
//  WhoFollows
//
//  Created by Maks Winters on 21.02.2025.
//
import UIKit

struct UserInfoPiece {
    // MARK: - Properties
    var title: String
    var icon: UIImage
    var value: String
    var subtitle: String?
    var requiredTileColor: CGColor
    // Action
    private(set) var action: (() -> Void)?
    // MARK: - Initializers
    init(
        title: String,
        icon: WFSymbols,
        value: String,
        subtitle: String? = nil,
        color: UIColor = UIColor(resource: .followerCellBackground)
    ) {
        self.title = title
        self.icon = icon.image
        self.value = value
        self.subtitle = subtitle
        self.requiredTileColor = color.cgColor
    }
    // MARK: - Methods
    mutating func setAction(_ action: (() -> Void)?) {
        self.action = action
    }
}

// MARK: - Hashable conformance
extension UserInfoPiece: Hashable {
    static func == (lhs: UserInfoPiece, rhs: UserInfoPiece) -> Bool {
        lhs.title == rhs.title && lhs.value == rhs.value && lhs.subtitle == rhs.subtitle
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(value)
        hasher.combine(subtitle ?? "")
    }
}
