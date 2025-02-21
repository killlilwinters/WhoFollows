//
//  WFSeparatorView.swift
//  WhoFollows
//
//  Created by Maks Winters on 21.02.2025.
//

import UIKit

class WFSeparatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .quaternaryLabel
        // Constraints
        heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
