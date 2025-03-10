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
    
    // MARK: - Setting images
    func setOfflineImage(image: UIImage) {
        self.image = image
    }
    func downloadImage(fromURL urlString: String) {
        // Set default so the cells don't reuse images they were previously assigned
        image = WFAvatarImageView.placeholderImage
        // Make the call
        Task {
            self.image = await NetworkManager.shared.downloadImage(fromURL: urlString)
        }
    }
    
    // MARK: Configure
    private func setupImageView() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = WFAvatarImageView.placeholderImage
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
}
