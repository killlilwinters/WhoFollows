//
//  FollowerCell.swift
//  WhoFollows
//
//  Created by Maks Winters on 07.02.2025.
//
// https://stackoverflow.com/questions/58620976/border-color-doesnt-change-when-changing-themes-in-ios-13
//

import UIKit

class FollowerCell: UICollectionViewCell {
    // MARK: Reuse ID
    static let reuseId = "FollowerCell"
    // MARK: Private properties
    private let avatarImageView = WFAvatarImageView(frame: .zero)
    private let usernameLabel = WFTitleLabel(frame: .zero)
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func set(follower: Follower) {
        usernameLabel.text = follower.login
    }
}

// MARK: - Setting Views
extension FollowerCell {
    private func setupCell() {
        layer.cornerRadius = 10
        layer.borderWidth = 5
        layer.borderColor = UIColor(resource: .followerCellBackground).cgColor
        addSubViews()
        setupLayout()
    }
}

// MARK: - Setting
extension FollowerCell {
    private func addSubViews() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
    }
}

// MARK: - Layout
extension FollowerCell {
    private func setupLayout() {
        // Username Label
        NSLayoutConstraint.activate([
            usernameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            usernameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        // Avatar Image View
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: usernameLabel.topAnchor, constant: -10)
        ])
    }
}
// MARK: Listen to theme change
extension FollowerCell {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            layer.borderColor = UIColor(resource: .followerCellBackground).cgColor
        }
    }
}

#Preview {
    let view = FollowerCell()
    view.set(follower: Follower(login: "test", avatarUrl: "https://example.com/avatar.png"))
    return view
}
