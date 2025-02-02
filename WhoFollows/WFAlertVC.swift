//
//  WFAlertVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 01.02.2025.
//

import UIKit

class WFAlertVC: UIViewController {
    // MARK: - Private Property
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .alertBackground
        containerView.layer.cornerRadius = 20
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.4
        containerView.layer.shadowRadius = 8
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    private let titleLabel = WFTitleLabel(textAlignment: .center, fontSize: 30)
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
        view.backgroundColor = .systemBackground
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
        // Other
        containerView.addSubview(button)
        messageLabel.text = message ?? "Unable to complete request..."
        messageLabel.numberOfLines = 2
        containerView.addSubview(vStack)
    }
}

// MARK: - Layout
extension WFAlertVC {
    func setupLayout() {
        // Container view
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22)
        ])
        // vStack
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            vStack.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            vStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20)
        ])
        // button
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            button.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
}

#Preview {
    WFAlertVC(alertTitle: "Error occured!", message: "Something went wrong!")
}
