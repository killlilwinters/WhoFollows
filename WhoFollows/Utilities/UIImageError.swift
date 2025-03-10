//
//  UIImageError.swift
//  WhoFollows
//
//  Created by Maks Winters on 10.03.2025.
//

import Foundation

enum UIImageError: LocalizedError {
    case missingCacheURL
    case conversionFailed
    case dataWritingFailed
    case deletionFailed
    
    var errorDescription: String? {
        switch self {
        case .missingCacheURL:
            return "Cache URL is missing"
        case .conversionFailed:
            return "Conversion of UIImage to Data failed"
        case .dataWritingFailed:
            return "Writing Data to disk failed"
        case .deletionFailed:
            return "Deleting file from disk failed"
        }
    }
}
