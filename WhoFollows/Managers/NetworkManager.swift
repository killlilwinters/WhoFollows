//
//  NetworkManager.swift
//  WhoFollows
//
//  Created by Maks Winters on 06.02.2025.
//

import UIKit

private enum Endpoints {
    
    static let followersPerPage: Int = 100
    private static let baseURL: String = "https://api.github.com/users/"
    
    static func followers(for username: String, page: Int) -> String {
        baseURL + username + "/followers?per_page=\(followersPerPage)&page=\(page)"
    }
    static func following(for username: String, page: Int) -> String {
        baseURL + username + "/following?per_page=\(followersPerPage)&page=\(page)"
    }
    static func user(for username: String) -> String {
        "\(baseURL)\(username)"
    }
}

class NetworkManager {
    private let decoder = JSONDecoder()
    // MARK: - Shared
    static let shared = NetworkManager()
    // MARK: - Followers per page public property
    let followersPerPage: Int = Endpoints.followersPerPage
    // MARK: - Caching
    let imageCache = NSCache<NSString, UIImage>()
    // MARK: - Initializers
    private init() {
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    // MARK: - Methods
    func makeFollowersRequest(for username: String, page: Int = 1) async throws -> [Follower] {
        try await makeRequest(with: Endpoints.followers(for: username, page: page))
    }
    
    func makeFollowingRequest(for username: String, page: Int = 1) async throws -> [Follower] {
        try await makeRequest(with: Endpoints.following(for: username, page: page))
    }
    
    func makeRequest(with endpoint: String) async throws -> [Follower] {
        // Request logic
        guard let url = URL(string: endpoint) else { throw NetworkError.invalidUsername }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Type cast to HTTPURLResponse
        let httpResponse = response as? HTTPURLResponse
        let responseCode = httpResponse?.statusCode
        // Check response code
        guard responseCode == 200 else {
            throw NetworkError.handleStatusCode(responseCode)
        }
        // Proceed to decoding data
        do {
            let result = try decoder.decode([Follower].self, from: data)
            return result
        } catch {
            throw NetworkError.invalidData
        }
        
    }
    
    func makeUserRequest(for username: String) async throws -> User {
        // Request logic
        let endpoint = Endpoints.user(for: username)
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        // Type cast to HTTPURLResponse
        let httpResponse = response as? HTTPURLResponse
        let responseCode = httpResponse?.statusCode
        // Check response code
        guard responseCode == 200 else {
            throw NetworkError.handleStatusCode(responseCode)
        }
        // Proceed to decoding data
        do {
            let user = try decoder.decode(User.self, from: data)
            return user
        } catch {
            throw NetworkError.invalidData
        }
    }
}

// MARK: - Image download methods
extension NetworkManager {
    
    func downloadImage(fromURL urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        
        let nsUrlString = urlString as NSString
        
        // Check if the image is in cache already
        if let image = imageCache.object(forKey: nsUrlString) {
            return image
        }
        // Proceed to download
        if let (data, _) = try? await URLSession.shared.data(from: url) {
            guard let image = UIImage(data: data) else { return nil }
            // Save to cache
            self.imageCache.setObject(image, forKey: nsUrlString)
            return image
        }
        return nil
    }
    
}
