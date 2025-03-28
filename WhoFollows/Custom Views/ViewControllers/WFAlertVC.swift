//
//  WFAlertVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 01.02.2025.
//

import UIKit

protocol WFAlertVCDelegate: AnyObject {
    func didTapButton()
}

final class WFAlertVC: UIViewController {
    // MARK: - Delegate
    weak var delegate: WFAlertVCDelegate?
    // MARK: - Private Property
    private let containerView = WFAlertContainerView(frame: .zero)
    private let titleLabel = WFTitleLabel(textAlignment: .center, fontSize: 25)
    private let messageLabel = WFBodyLabel(textAlignment: .center, numberOfLines: 3)
    private lazy var button = WFGenericButtonVC(text: buttonTitle ?? "OK", color: .systemOrange)
    // MARK: - Stacks
    private var vStack: UIStackView = WFStack(axis: .vertical, spacing: 20)
    // MARK: - Public properties
    private var alertTitle: String?
    private var message: String?
    private var buttonTitle: String?
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
    private func setupButton() {
        button.addAction(UIAction { _ in self.buttonAction() }, for: .touchUpInside)
    }
}

// MARK: - Setting Views
extension WFAlertVC {
    private func setupView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        addSubViews()
        setupLayout()
        setupButton()
        setupContents()
    }
    private func buttonAction() {
        delegate?.didTapButton()
        dismiss(animated: true)
    }
}

// MARK: - Setting
extension WFAlertVC {
    private func addSubViews() {
        // Add container
        view.addSubview(containerView)
        // Setup vStack
        view.addSubview(vStack)
        vStack.alignment = .center
        vStack.addArrangedSubviews(titleLabel, messageLabel, button)
        // Other
        containerView.addSubview(vStack)
    }
    private func setupContents() {
        titleLabel.text = alertTitle
        messageLabel.text = message ?? "Unable to complete request..."
        // The button's title is set in it's initializer lazily
    }
}

// MARK: - Layout
extension WFAlertVC {
    private func setupLayout() {
        // Container view
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: vStack.topAnchor, constant: -20),
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
