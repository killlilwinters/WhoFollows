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
        getFromCache(for: urlString) { image in
            self.image = image
            return
        }
        // Proceed to download
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            guard let data = data else {
                return
            }
            guard let image = UIImage(data: data) else {
                return
            }
            self.setToCache(image: image, for: urlString)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}

// MARK: - Caching logic
extension WFAvatarImageView {
    private func getFromCache(for urlString: String, completion: @escaping (UIImage?) -> Void) {
        let nsUrlString = urlString as NSString
        if let image = cache.object(forKey: nsUrlString) {
            self.image = image
            completion(image)
        }
    }
    private func setToCache(image: UIImage, for urlString: String) {
        let nsUrlString = urlString as NSString
        self.cache.setObject(image, forKey: nsUrlString)
    }
}
