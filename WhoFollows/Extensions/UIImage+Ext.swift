//
//  UIImage+Ext.swift
//  WhoFollows
//
//  Created by Maks Winters on 02.03.2025.
//

import UIKit

extension UIImage {
    
    func saveToDisk(follower: Follower) -> String? {
        guard let data = self.jpegData(compressionQuality: 0.6) else { return nil }
        let fileName = "\(follower.login).jpg"
        guard let url = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent(fileName) else { return nil }
        
        do {
            try data.write(to: url)
            return url.path
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
    func getFromDisk(fileName: String) -> UIImage? {
        guard let url = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent(fileName) else { return nil }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    func removeFromDisk(fileName: String) {
        guard let url = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent(fileName) else { return }
        
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}
