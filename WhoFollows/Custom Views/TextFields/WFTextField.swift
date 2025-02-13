//
//  WFTextField.swift
//  WhoFollows
//
//  Created by Maks Winters on 28.01.2025.
//
// https://medium.com/nyc-design/swift-4-add-icon-to-uitextfield-48f5ebf60aa1
//
// https://stackoverflow.com/questions/788323/how-to-disable-enable-the-return-key-in-a-uitextfield
//

import UIKit

final class WFTextField: UITextField {
    private var padding = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 20)
    // MARK: - Initializers
    init(icon: UIImage? = nil, placeholder: String) {
        super.init(frame: .zero)
        setupTextField(icon: icon, placeholder: placeholder)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Override methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    // MARK: - Private methods
    private func setupTextField(icon: UIImage?, placeholder: String) {
        translatesAutoresizingMaskIntoConstraints = false
        if let icon {
            padding = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 20)
            setIcon(icon)
        }
        textColor = .white
        layer.cornerRadius = 20
        layer.backgroundColor = UIColor.systemGray2.cgColor
        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.4
        // Keyboard
        keyboardType = .default
        returnKeyType = .go
        enablesReturnKeyAutomatically = true
        autocorrectionType = .no
        autocapitalizationType = .none
        // Other
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 15, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftViewMode = .always
        leftView = iconContainerView
        tintColor = .white
    }
}

#Preview {
    WFTextField(icon: UIImage(systemName: "person"), placeholder: "Just look at that icon!")
}
