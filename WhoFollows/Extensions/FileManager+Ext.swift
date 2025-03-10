//
//  FileManager+Ext.swift
//  WhoFollows
//
//  Created by Maks Winters on 04.03.2025.
//

import Foundation

extension FileManager {
    
    static let cacheURL: URL? = {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    }()
    
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
