//
//  UserTileData.swift
//  WhoFollows
//
//  Created by Maks Winters on 21.02.2025.
//
import UIKit

struct UserTileData {
    // MARK: - Properties
    var title: String
    var subtitle: String?
    var icon: UIImage
    var value: String
    var tileColor: UIColor
    // Action
    private(set) var action: (() -> Void)?
    // MARK: - Initializers
    init(
        title: String,
        subtitle: String? = nil,
        icon: WFSymbols,
        value: String,
        tileColor: UIColor = UIColor(resource: .followerCellBackground)
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon.image
        self.value = value
        self.tileColor = tileColor
    }
    // MARK: - Methods
    mutating func setAction(_ action: (() -> Void)?) {
        self.action = action
    }
}

// MARK: - Hashable conformance
extension UserTileData: Hashable {
    static func == (lhs: UserTileData, rhs: UserTileData) -> Bool {
        lhs.title == rhs.title && lhs.value == rhs.value && lhs.subtitle == rhs.subtitle
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(value)
        hasher.combine(subtitle ?? "")
    }
}
