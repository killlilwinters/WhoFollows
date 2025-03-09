//
//  UIView+Ext.swift
//  WhoFollows
//
//  Created by Maks Winters on 09.03.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
