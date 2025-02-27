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
        // Decode
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = formatter.date(from: user.createdAt) else { return "Unable to resolve date..." }
        // Encode
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
}
