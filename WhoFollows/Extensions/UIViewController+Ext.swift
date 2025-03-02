//
//  UIViewController+Ext.swift
//  WhoFollows
//
//  Created by Maks Winters on 02.02.2025.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentWFAlertVCOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = WFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    func displayEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = WFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemOrange
        present(safariVC, animated: true)
    }
 }
