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
    private let cache = NetworkManager.shared.imageCache
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
    // MARK: Network request
    func downloadImage(from urlString: String) {
        // Set default so the cells don't reuse images they were previously assigned
        image = WFAvatarImageView.placeholderImage
        // Check if the image is in cache already
        if let image = getFromCache(for: urlString) {
            self.image = image
            return
        }
        // Proceed to download
        Task { [weak self] in
            guard let self = self else { return }
            let image = await NetworkManager.shared.downloadImage(from: urlString)
            self.setToCache(image: image, for: urlString)
            
            self.image = image
        }
    }
}

// MARK: - Caching logic
extension WFAvatarImageView {
    private func getFromCache(for urlString: String) -> UIImage? {
        let nsUrlString = urlString as NSString
        if let image = cache.object(forKey: nsUrlString) {
            return image
        }
        return nil
    }
    private func setToCache(image: UIImage, for urlString: String) {
        let nsUrlString = urlString as NSString
        self.cache.setObject(image, forKey: nsUrlString)
    }
}
