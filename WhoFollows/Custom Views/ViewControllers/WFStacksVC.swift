//
//  WFStacksVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 01.02.2025.
//

import UIKit

final class WFStack: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: Alignment = .fill) {
        super.init(frame: .zero)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        setupStackView()
    }
    private func setupStackView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
