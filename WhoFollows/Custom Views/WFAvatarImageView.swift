//
//  WFAvatarImageView.swift
//  WhoFollows
//
//  Created by Maks Winters on 07.02.2025.
//

import UIKit

class WFAvatarImageView: UIImageView {
    // MARK: Private properties
    let placeholderImage: UIImage = UIImage(resource: .avatarPlaceholder)
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Configure
    func setupImageView() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
}
