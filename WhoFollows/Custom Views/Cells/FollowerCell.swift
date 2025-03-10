//
//  FollowerCell.swift
//  WhoFollows
//
//  Created by Maks Winters on 07.02.2025.
//
// https://stackoverflow.com/questions/58620976/border-color-doesnt-change-when-changing-themes-in-ios-13
//

import UIKit

final class FollowerCell: UICollectionViewCell {
    // MARK: - Reuse ID
    static let reuseId = "FollowerCell"
    // MARK: - Private properties
    private let avatarImageView = WFAvatarImageView(frame: .zero)
    private let usernameLabel = WFTitleLabel(textAlignment: .center, fontSize: 20)
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        registerForApperanceChanges()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Set method
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(fromURL: follower.avatarUrl)
    }
}

// MARK: - Setting
extension FollowerCell {
    
    private func setupCell() {
        layer.cornerRadius = 10
        layer.borderWidth = 5
        layer.borderColor = UIColor(resource: .followerCellBackground).cgColor
        addSubViews()
        setupLayout()
    }
    
    private func addSubViews() {
        contentView.addSubviews(avatarImageView, usernameLabel)
    }
    
}

// MARK: - Layout
extension FollowerCell {
    private func setupLayout() {
        // Username Label
        NSLayoutConstraint.activate([
            usernameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 15),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        // Set required priority for label so it doesn't move
        usernameLabel.setContentHuggingPriority(
            .required,
            for: .vertical
        )
        usernameLabel.setContentCompressionResistancePriority(
            .required,
            for: .vertical
        )
        // Avatar Image View
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
// MARK: - Listen to theme change
extension FollowerCell: ManualTheming {
    func updateAppearance() {
        layer.borderColor = UIColor(resource: .followerCellBackground).cgColor
    }
}

#Preview {
    let view = FollowerCell()
    view.set(follower: Follower(login: "test", avatarUrl: "https://example.com/avatar.png"))
    return view
}
