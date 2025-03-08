//
//  WFAlertContainerView.swift
//  WhoFollows
//
//  Created by Maks Winters on 08.03.2025.
//

import UIKit

class WFAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContentView() {
        backgroundColor = .alertBackground
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
