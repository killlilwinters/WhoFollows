//
//  String+Ext.swift
//  WhoFollows
//
//  Created by Maks Winters on 18.02.2025.
//

import Foundation

extension String {
    func containsCaseInsensitive(_ substring: String) -> Bool {
        range(of: substring, options: .caseInsensitive) != nil
    }
}
