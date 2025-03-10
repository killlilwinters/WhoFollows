//
//  NetworkError.swift
//  WhoFollows
//
//  Created by Maks Winters on 06.02.2025.
//

enum NetworkError: String, Error {
    case invalidUsername = "This username is invalid, please, try again."
    case somethingWentWrong = "Something went wrong, please, try again or check your internet connection."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unknown = "Unknown error, please, try again."
    case e400 = "Bad Request, please, try again."
    case e401 = "Unauthorized."
    case e403 = "Forbidden."
    case e404 = "User not found..."
    case e500to599 = "Internal Server Error"
    case appsLogicError = "Internal App's Logic Error"
    
    static func handleStatusCode(_ statusCode: Int?) -> NetworkError {
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
