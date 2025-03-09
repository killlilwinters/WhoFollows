//
//  WFUserInfoFooterVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 27.02.2025.
//

import UIKit

final class WFUserInfoFooterVC: UIViewController {
    // MARK: - Properties
    private let textLabel = WFBodyLabel(textAlignment: .center, numberOfLines: 1)
    private let separator = WFSeparatorView(frame: .zero)
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(separator, textLabel)
        applyConstraints()
    }
    private func applyConstraints() {
        let padding: CGFloat = 20
        let widthConstraintMultiplier: CGFloat = 0.9
        NSLayoutConstraint.activate([
            separator.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -padding),
            separator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separator.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthConstraintMultiplier)
        ])
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    func setUser(_ user: User) {
        textLabel.text = StaticDateFormatter.decodeDateForUser(user: user)
    }

}

#Preview {
    let view = WFUserInfoFooterVC()
    view.setUser(killlilwinters)
    return view
}
