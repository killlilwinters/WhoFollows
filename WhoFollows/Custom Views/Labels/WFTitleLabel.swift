//
//  WFTitleLabel.swift
//  WhoFollows
//
//  Created by Maks Winters on 01.02.2025.
//

import UIKit

final class WFTitleLabel: UILabel {

    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .headline), size: fontSize)
    }
    private func setupLabel() {
        textColor = .label
        adjustsFontSizeToFitWidth = false
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        numberOfLines = 1
        translatesAutoresizingMaskIntoConstraints = false
    }
}
