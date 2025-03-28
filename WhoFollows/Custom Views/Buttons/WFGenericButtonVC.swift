//
//  WFGenericButtonVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 01.02.2025.
//

import UIKit

final class WFGenericButtonVC: UIButton {

    init(text: String,
         color: UIColor,
         image: UIImage? = nil,
         configType: UIButton.Configuration = .filled()
    ) {
        super.init(frame: .zero)
        setupButton(text: text, color: color, image: image, configType: configType)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private methods
    private func setupButton(
        text: String,
        color: UIColor,
        image: UIImage? = nil,
        configType: UIButton.Configuration
    ) {
        
        var config = configType
        if configType == .borderedTinted() { config.baseForegroundColor = color }
        if image != nil { config.image = image }
        
        config.title = text
        config.buttonSize = .large
        config.background.cornerRadius = 15
        config.imagePadding = 8
        config.contentInsets = .init(top: 12, leading: 20, bottom: 12, trailing: 20)
        config.baseBackgroundColor = color
        // Other
        configuration = config
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}

#Preview {
    WFGenericButtonVC(text: "Preview", color: .systemBlue)
}
