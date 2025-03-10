//
//  UITextField+Ext.swift
//  WhoFollows
//
//  Created by Maks Winters on 07.02.2025.
//
// https://stackoverflow.com/a/49648916
//

import UIKit

private var _maxLength = 10

extension UITextField {

    var maxLength: Int? {
        get {
            return _maxLength
        }
        set {
            removeTarget(self, action: #selector(limitLength), for: .editingChanged)
            if let newValue {
                _maxLength = newValue
                addTarget(self, action: #selector(limitLength), for: .editingChanged)
            } else {
                _maxLength = 10
            }
        }
    }

    @objc private func limitLength(_ textField: UITextField) {
        let selection = selectedTextRange
        text = textField.text?.prefix(maxLength ?? _maxLength).description
        selectedTextRange = selection
    }
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
