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
}
