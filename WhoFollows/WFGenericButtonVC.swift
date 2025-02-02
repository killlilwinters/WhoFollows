//
//  WFGenericButtonVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 01.02.2025.
//

import UIKit
final class WFGenericButtonVC: UIButton {

    init(text: String, color: UIColor) {
        super.init(frame: .zero)
        setupButton(text: text, color: color)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private methods
    private func setupButton(text: String, color: UIColor) {
        // Config
        var config = UIButton.Configuration.filled()
        config.title = text
        config.buttonSize = .large
        config.background.cornerRadius = 15
        config.imagePadding = 8
        config.contentInsets = .init(top: 12, leading: 20, bottom: 12, trailing: 20)
        config.baseBackgroundColor = color
        config.baseForegroundColor = .white
        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.4
        // Other
        configuration = config
        translatesAutoresizingMaskIntoConstraints = false
    }
}

#Preview {
    let button = WFGenericButtonVC(text: "Preview", color: .systemBlue)
    return button
}
