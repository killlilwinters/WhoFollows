//
//  UIImage+Ext.swift
//  WhoFollows
//
//  Created by Maks Winters on 02.03.2025.
//

import UIKit

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

extension UIImage {
    
    func saveToDisk(follower: Follower) throws -> String? {
        guard let url = FileManager.cacheURL else {
            throw UIImageError.missingCacheURL
        }
        let itemURL = url.appendingPathComponent(follower.login)
        
        if let data = self.jpegData(compressionQuality: 0.6) {
            
            do { return try data.writeImageData(at: itemURL) } catch { throw error }
            
        } else if let data = self.pngData() {
            
            do { return try data.writeImageData(at: itemURL) } catch { throw error }
            
        } else {
            throw UIImageError.conversionFailed
        }
        
    }
    
    static func getFromDisk(login fileName: String) throws -> UIImage? {
        guard let url = FileManager.cacheURL else {
            throw UIImageError.missingCacheURL
        }
        
        let itemURL = url.appendingPathComponent(fileName)
        
        return UIImage(contentsOfFile: itemURL.path)
    }
    
    static func removeFromDisk(login fileName: String) throws {
        guard let url = FileManager.cacheURL else {
            throw UIImageError.missingCacheURL
        }
        
        let itemURL = url.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: itemURL)
        } catch {
            throw UIImageError.deletionFailed
        }
        
    }
    
}
