//
//  WFAvatarImageView.swift
//  WhoFollows
//
//  Created by Maks Winters on 07.02.2025.
//

import UIKit

final class WFAvatarImageView: UIImageView {
    // MARK: Private properties
    private static let placeholderImage = UIImage(resource: .avatarPlaceholder)
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
    private func setupImageView() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = WFAvatarImageView.placeholderImage
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
    func setOfflineImage(image: UIImage) {
        self.image = image
    }
    // MARK: Network request
    func downloadImage(from urlString: String) {
        // Set default so the cells don't reuse images they were previously assigned
        image = WFAvatarImageView.placeholderImage
        // Make the call
        Task { [weak self] in
            guard let self = self else { return }
            self.image = await NetworkManager.shared.downloadImage(from: urlString)
        }
    }
}
