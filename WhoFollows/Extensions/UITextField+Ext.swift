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
            if let newValue = newValue {
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
}
