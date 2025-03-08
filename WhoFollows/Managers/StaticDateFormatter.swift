//
//  StaticDateFormatter.swift
//  WhoFollows
//
//  Created by Maks Winters on 27.02.2025.
//

import Foundation

struct StaticDateFormatter {
    // MARK: Properties
    static let formatter = DateFormatter()
    // MARK: Methods
    static func decodeDateForUser(user: User) -> String {
        let formatter = StaticDateFormatter.formatter
        let date = user.createdAt
        // Encode
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
}
