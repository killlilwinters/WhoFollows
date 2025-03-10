//
//  FavoriteCell.swift
//  WhoFollows
//
//  Created by Maks Winters on 07.03.2025.
//

import UIKit

final class FavoriteCell: UITableViewCell {
    // MARK: - Reuse ID
    static let reuseID = "FavoriteCell"
    // MARK: - Private properties
    private let avatarImageView = WFAvatarImageView(frame: .zero)
    private let usernameLabel = WFSecondaryTitleLabel()
    private let hStack = WFStack(axis: .horizontal, spacing: 12)
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Set method
    func set(with follower: Follower, image: UIImage?) {
        usernameLabel.text = follower.login
        
        guard let image = image else { return }
        avatarImageView.setOfflineImage(image: image)
    }
}

// MARK: - Setting
extension FavoriteCell {
    
    private func setupCell() {
        usernameLabel.text = "This is a user"
        addSubview(hStack)
        hStack.addArrangedSubview(avatarImageView)
        hStack.addArrangedSubview(usernameLabel)
        setupConstraints()
        
        accessoryType = .disclosureIndicator
    }
    
}

// MARK: - Layout
extension FavoriteCell {
    
    func setupConstraints() {
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            hStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding)
        ])
        let width = UIScreen.main.bounds.width * 0.15
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: width),
            avatarImageView.widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
}

#Preview {
    FavoriteCell(style: .default, reuseIdentifier: nil)
}
