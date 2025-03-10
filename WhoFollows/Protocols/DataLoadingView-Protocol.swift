//
//  DataLoadingView-Protocol.swift
//  WhoFollows
//
//  Created by Maks Winters on 13.02.2025.
//

import UIKit

protocol DataLoadingView: UIViewController {
    var containerView: UIView! { get set }
    func showLoadingView()
    func dismissLoadingView()
}

extension DataLoadingView {
    func showLoadingView() {
        // Container view setup
        containerView = UIView(frame: view.bounds)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        // Setup activity indicator
        UIView.animate(withDuration: 0.5) { self.containerView.alpha = 0.8 }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        // Setup constraints
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        // Start animating the activity indicator
        DispatchQueue.main.async {
            self.view.addSubview(self.containerView)
            activityIndicator.startAnimating()
        }
    }
    @MainActor
    func dismissLoadingView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.containerView.alpha = 0
        }, completion: { _ in
            self.containerView.removeFromSuperview()
        })
    }
}
