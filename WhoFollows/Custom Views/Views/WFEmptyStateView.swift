//
//  WFEmptyStateView.swift
//  WhoFollows
//
//  Created by Maks Winters on 13.02.2025.
//

import UIKit

class WFEmptyStateView: UIView {
    // MARK: - Properties
    let messageLabel = WFTitleLabel(textAlignment: .center, fontSize: 40)
    private let imageLogo = UIImageView()
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    // MARK: - Setup
    func updateLabelText(_ text: String) {
        messageLabel.text = text
    }
    private func setupView() {
        // Adding subviews
        addSubviews(messageLabel, imageLogo)
        // Message label setup
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        // Image logo setup
        imageLogo.image = UIImage(resource: .emptyStateLogo)
        imageLogo.contentMode = .scaleAspectFit
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
    }
    // MARK: - Layout setup
    private func setupLayout() {
        let screenHeight = UIScreen.main.bounds.height
        // messageLabel
        NSLayoutConstraint.activate([
            messageLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -(screenHeight / 4)),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        // imageLogo
        NSLayoutConstraint.activate([
            imageLogo.centerXAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            imageLogo.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 50),
            imageLogo.widthAnchor.constraint(equalToConstant: screenHeight / 1.6),
            imageLogo.heightAnchor.constraint(equalToConstant: screenHeight / 1.6)
        ])
        imageLogo.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}

#Preview {
    WFEmptyStateView(message: "This user doesn't seem to have any followers yet...")
}
