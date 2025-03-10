//
//  UIStackView+Ext.swift
//  WhoFollows
//
//  Created by Maks Winters on 10.03.2025.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach { addArrangedSubview($0) }
    }
}
