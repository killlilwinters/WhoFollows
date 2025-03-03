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
    
    var errorDescription: String? {
        switch self {
        case .missingCacheURL:
            return "Cache URL is missing"
        case .conversionFailed:
            return "Conversion of UIImage to Data failed"
        case .dataWritingFailed:
            return "Writing Data to disk failed"
        }
    }
}

extension UIImage {
    
    static let cacheURL: URL? = {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    }()
    
    func saveToDisk(follower: Follower) throws -> String? {
        guard let url = UIImage.cacheURL else {
            throw UIImageError.missingCacheURL
        }
        let itemURL = url.appendingPathComponent(follower.login)
        
        guard let data = self.jpegData(compressionQuality: 0.6) else {
            throw UIImageError.conversionFailed
        }
        
        do {
            try data.write(to: itemURL)
            return itemURL.path
        } catch {
            throw UIImageError.dataWritingFailed
        }
        
    }
    
    static func getFromDisk(fileName: String) -> UIImage? {
        guard let url = cacheURL else { return nil }
        
        let itemURL = url.appendingPathComponent(fileName)
        
        return UIImage(contentsOfFile: itemURL.path)
    }
    
    static func removeFromDisk(fileName: String) {
        guard let url = cacheURL else { return }
        
        let itemURL = url.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: itemURL)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    static func clearCache() {
        let fileManager = FileManager.default
        guard let url = cacheURL else { return }
        
        do {
            let items = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
            try items.forEach {
                try fileManager.removeItem(at: $0)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
