//
//  NetworkManager.swift
//  WhoFollows
//
//  Created by Maks Winters on 06.02.2025.
//

import UIKit

private enum Endpoints {
    private static let baseURL: String = "https://api.github.com/users/"
    static func followers(for username: String, page: Int) -> String {
        baseURL + username + "/followers?per_page=\(100)&page=\(page)"
    }
    static func user(for username: String) -> String {
        "\(baseURL)\(username)"
    }
}

class NetworkManager {
    // MARK: - Shared
    static let shared = NetworkManager()
    // MARK: - Link Settings
    private let baseURL = "https://api.github.com/users/"
    let followersPerPage = 100
    // MARK: - Caching
    let imageCache = NSCache<NSString, UIImage>()
    // MARK: - Private init
    private init() {}
    // MARK: - Methods
    func makeRequest<T: Decodable>(
        for username: String,
        page: Int? = 1,
        completion: @escaping (Result<T, NetworkError>) -> Void) {
            // Generic endpoint resolve
            var endpoint = String()
            if T.self is [Follower].Type, page != nil {
                endpoint = Endpoints.followers(for: username, page: page!)
            } else if T.self is User.Type {
                endpoint = Endpoints.user(for: username)
            } else {
                completion(.failure(.appsLogicError))
            }
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
                    completion(.failure(self.handleStatusCode(responseCode)))
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
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    print(error)
                    completion(.failure(.invalidData))
                }
            }
            task.resume()
        }
    private func handleStatusCode(_ statusCode: Int?) -> NetworkError {
        guard let statusCode else {
            return .unknown
        }
        switch statusCode {
        case 400:
            return .e400
        case 401:
            return .e401
        case 403:
            return .e403
        case 404:
            return .e404
        case 500...599:
            return .e500to599
        default:
            return .unknown
        }
    }
}
