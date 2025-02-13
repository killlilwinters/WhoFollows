//
//  WFAlertVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 01.02.2025.
//

import UIKit

final class WFAlertVC: UIViewController {
    // MARK: - Private Property
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .alertBackground
        containerView.layer.cornerRadius = 20
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    private let titleLabel = WFTitleLabel(textAlignment: .center, fontSize: 25)
    private let messageLabel = WFBodyLabel(textAlignment: .center)
    private let button = WFGenericButtonVC(text: "OK", color: .systemOrange)
    private var vStack: UIStackView = WFStack(axis: .vertical, spacing: 20)
    // MARK: - Public Property
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    // MARK: - Initializers
    init(alertTitle: String? = nil, message: String? = nil, buttonTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

// MARK: - Logic

extension WFAlertVC {
}

// MARK: - Setting Views

extension WFAlertVC {
    private func setupView() {
        addSubVIews()
        setupLayout()
    }
}

// MARK: - Setting
extension WFAlertVC {
    private func addSubVIews() {
        // Add container
        view.addSubview(containerView)
        titleLabel.text = alertTitle
        // Setup vStack
        view.addSubview(vStack)
        vStack.alignment = .center
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(messageLabel)
        vStack.addArrangedSubview(button)
        // Other
//        containerView.addSubview(button)
        messageLabel.text = message ?? "Unable to complete request..."
        messageLabel.numberOfLines = 3
        containerView.addSubview(vStack)
    }
}

// MARK: - Layout
extension WFAlertVC {
    func setupLayout() {
        // Container view
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: vStack.topAnchor),
            containerView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: 15),
            containerView.leadingAnchor.constraint(equalTo: vStack.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: vStack.trailingAnchor)
        ])
        // vStack
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80)
        ])
        // button
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: vStack.centerXAnchor),
            button.widthAnchor.constraint(equalTo: vStack.widthAnchor, multiplier: 0.6),
            button.bottomAnchor.constraint(equalTo: vStack.bottomAnchor, constant: -20)
        ])
        // titleLabel
        NSLayoutConstraint.activate([
            messageLabel.widthAnchor.constraint(equalTo: vStack.widthAnchor, multiplier: 0.8)
        ])
    }
}

#Preview {
    WFAlertVC(alertTitle: "Error occured!", message: NetworkError.somethingWentWrong.rawValue)
}
