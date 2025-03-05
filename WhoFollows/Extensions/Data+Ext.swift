//
//  Data+Ext.swift
//  WhoFollows
//
//  Created by Maks Winters on 05.03.2025.
//
import Foundation

extension Data {
    func writeImageData(at url: URL) throws -> String {
        do {
            try write(to: url)
            return url.path
        } catch {
            throw UIImageError.dataWritingFailed
        }
    }
}
