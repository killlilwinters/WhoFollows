//
//  WFBodyLabel.swift
//  WhoFollows
//
//  Created by Maks Winters on 01.02.2025.
//

import UIKit

final class WFBodyLabel: UILabel {

    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(textAlignment: NSTextAlignment, numberOfLines: Int) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
    private func setupLabel() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }

}
