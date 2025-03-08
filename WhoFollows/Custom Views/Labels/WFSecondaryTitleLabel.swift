//
//  WFSecondaryTitleLabel.swift
//  WhoFollows
//
//  Created by Maks Winters on 20.02.2025.
//

import UIKit

class WFSecondaryTitleLabel: UILabel {

    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(codeer:) has not been implemented")
    }
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    private func setupLabel() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
