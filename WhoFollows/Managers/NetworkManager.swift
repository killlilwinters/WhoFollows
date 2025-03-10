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
    // MARK: - Shared
    static let shared = NetworkManager()
    // MARK: - Followers per page public property
    let followersPerPage: Int = Endpoints.followersPerPage
    // MARK: - Caching
    let imageCache = NSCache<NSString, UIImage>()
    
    // MARK: - Methods
    func makeFollowersRequest(
        for username: String,
        page: Int = 1,
        completion: @escaping (Result<[Follower], NetworkError>) -> Void
    ) {
        self.makeRequest(with: Endpoints.followers(for: username, page: page)) { result in
            completion(result)
        }
    }
    
    func makeFollowingRequest(
        for username: String,
        page: Int = 1,
        completion: @escaping (Result<[Follower], NetworkError>) -> Void
    ) {
        self.makeRequest(with: Endpoints.following(for: username, page: page)) { result in
            completion(result)
        }
    }
    
    private func makeRequest(
        with endpoint: String,
        completion: @escaping (Result<[Follower], NetworkError>) -> Void
    ) {
        // Request logic
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.somethingWentWrong))
                return
            }
            // Type cast to HTTPURLResponse
            let httpResponse = response as? HTTPURLResponse
            let responseCode = httpResponse?.statusCode
            // Check response code
            guard responseCode == 200 else {
                completion(.failure(NetworkError.handleStatusCode(responseCode)))
                return
            }
            // Check data
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            // Proceed to decoding data
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode([Follower].self, from: data)
                completion(.success(result))
            } catch {
                print(error)
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func makeUserRequest(
        for username: String,
        completion: @escaping (Result<User, NetworkError>) -> Void
    ) {
        // Request logic
        let endpoint = Endpoints.user(for: username)
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.somethingWentWrong))
                return
            }
            // Type cast to HTTPURLResponse
            let httpResponse = response as? HTTPURLResponse
            let responseCode = httpResponse?.statusCode
            // Check response code
            guard responseCode == 200 else {
                completion(.failure(NetworkError.handleStatusCode(responseCode)))
                return
            }
            // Check data
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            // Proceed to decoding data
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let result = try decoder.decode(User.self, from: data)
                completion(.success(result))
            } catch {
                print(error)
                completion(.failure(.invalidData))
            }
        }
        task.resume()
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
