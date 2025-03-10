//
//  WFReusableView.swift
//  WhoFollows
//
//  Created by Maks Winters on 10.03.2025.
//

import UIKit

class WFReusableView: UICollectionReusableView {
    let view = UIView()
    class var reuseID: String { "WFReusableView" }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    func addChildVC(childVC: UIViewController, parentVC: UIViewController) {
        parentVC.addChild(childVC) // Add child VC to parent
        view.addSubview(childVC.view) // Add child's view to headerView
        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            childVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            childVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            childVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            childVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        childVC.didMove(toParent: parentVC) // Notify child VC that it was added
    }
    
}
