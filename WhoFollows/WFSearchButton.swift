//
//  WFSearchButton.swift
//  WhoFollows
//
//  Created by Maks Winters on 01.02.2025.
//

import UIKit

class WFSearchButton: UIButton {
    
    //MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setupButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func setupButton() {
    
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "magnifyingglass")
        config.buttonSize = .large
        config.background.cornerRadius = 20
        config.imagePadding = 8
        config.contentInsets = .init(top: 12, leading: 20, bottom: 12, trailing: 20)
        config.baseBackgroundColor = UIColor.systemGray2
        config.baseForegroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.4
        
        configuration = config
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}

#Preview {
    let button = WFSearchButton()
    return button
}
