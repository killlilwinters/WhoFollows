//
//  UIViewController+Ext.swift
//  WhoFollows
//
//  Created by Maks Winters on 02.02.2025.
//

import UIKit
import SafariServices

extension DataLoadingView where Self: UIViewController {
    func handleErrorResult(error: any Error, delegate: WFAlertVCDelegate? = nil) {
        dismissLoadingView()
        if let error = error as? NetworkError {
            presentWFAlert(
                title: .somethingWentWrong,
                message: error.rawValue,
                delegate: delegate
            )
        } else if let error = error as? CoreDataError {
            presentWFAlert(
                title: WFAlertTitleMessages.somethingWentWrong,
                message: error.localizedDescription,
                delegate: delegate
            )
        } else {
            presentDefaultError()
        }
    }
}

extension UIViewController {
    
    func presentWFAlert(
        title: WFAlertTitleMessages,
        message: String,
        buttonTitle: String? = nil,
        delegate: WFAlertVCDelegate? = nil
    ) {
        let titleString = title.rawValue
        let alertVC = WFAlertVC(alertTitle: titleString, message: message, buttonTitle: buttonTitle)
        alertVC.delegate = delegate
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        self.present(alertVC, animated: true)
    }
    
    func presentDefaultError(delegate: WFAlertVCDelegate? = nil) {
        let alertVC = WFAlertVC(
            alertTitle: WFAlertTitleMessages.somethingWentWrong.rawValue,
            message: "Unable to load data. Please try again later.",
            buttonTitle: "OK"
        )
        alertVC.delegate = delegate
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        self.present(alertVC, animated: true)
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
