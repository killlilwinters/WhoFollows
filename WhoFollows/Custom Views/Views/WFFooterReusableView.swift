//
//  WFFooterReusableView.swift
//  WhoFollows
//
//  Created by Maks Winters on 08.03.2025.
//
import UIKit

final class WFFooterReusableView: UICollectionReusableView {
    private let footerView = UIView()
    static let reuseId = "WFFooterReusableView"
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        addSubview(footerView)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(equalTo: topAnchor),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    func addChildVC(childVC: UIViewController, parentVC: UIViewController) {
        parentVC.addChild(childVC) // Add child VC to parent
        footerView.addSubview(childVC.view) // Add child's view to headerView
        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childVC.view.topAnchor.constraint(equalTo: footerView.topAnchor),
            childVC.view.bottomAnchor.constraint(equalTo: footerView.bottomAnchor),
            childVC.view.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
            childVC.view.trailingAnchor.constraint(equalTo: footerView.trailingAnchor)
        ])
        childVC.didMove(toParent: parentVC) // Notify child VC that it was added
    }
}
