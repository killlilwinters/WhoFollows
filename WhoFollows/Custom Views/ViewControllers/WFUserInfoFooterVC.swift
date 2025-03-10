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
    
    func setUser(_ user: User) {
        textLabel.text = StaticDateFormatter.decodeDateForUser(user: user)
    }
    
    private func applyConstraints() {
        let padding: CGFloat = 20
        let widthConstraintMultiplier: CGFloat = 0.9
        
        // separator
        NSLayoutConstraint.activate([
            separator.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -padding),
            separator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separator.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthConstraintMultiplier)
        ])
        // textLabel
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

#Preview {
    let view = WFUserInfoFooterVC()
    view.setUser(killlilwinters)
    return view
}
