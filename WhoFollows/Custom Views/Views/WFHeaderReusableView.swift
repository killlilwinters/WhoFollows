//
//  WFHeaderReusableView.swift
//  WhoFollows
//
//  Created by Maks Winters on 20.02.2025.
//

import UIKit

final class WFHeaderReusableView: UICollectionReusableView {
    let headerView = UIView()
    static let reuseId = "WFHeaderReusableView"
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    func addChildVC(childVC: UIViewController, parentVC: UIViewController) {
        parentVC.addChild(childVC) // Add child VC to parent
        headerView.addSubview(childVC.view) // Add child's view to headerView
        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childVC.view.topAnchor.constraint(equalTo: headerView.topAnchor),
            childVC.view.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            childVC.view.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            childVC.view.trailingAnchor.constraint(equalTo: headerView.trailingAnchor)
        ])
        childVC.didMove(toParent: parentVC) // Notify child VC that it was added
    }
}
