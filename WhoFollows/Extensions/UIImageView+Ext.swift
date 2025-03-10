//
//  UIImageView+Ext.swift
//  WhoFollows
//
//  Created by Maks Winters on 20.02.2025.
//

import UIKit

extension UIImageView {
    func roundImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}
