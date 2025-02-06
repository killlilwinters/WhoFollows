//
//  SearchVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 28.01.2025.
//
// https://medium.com/@dineshk1389/content-hugging-and-compression-resistance-in-ios-35a0e8f19118
//

import UIKit

final class SearchVC: UIViewController {
    // MARK: - Private Property
    private let imageLogoView = UIImageView()
    private let searchTextField: UITextField = WFTextField(
        icon: UIImage(systemName: "person"),
        placeholder: "Search a user"
    )
    private let searchButton: UIButton = WFSearchButton()
    // MARK: - Stacks
    private var searchGroupVStack: UIStackView = WFStack(axis: .vertical, spacing: 10)
    private var searchRowHStack: UIStackView = WFStack(axis: .horizontal, spacing: 10)
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

}

// MARK: - Logic
extension SearchVC {
    private func pushFollowersListVC() {
        let followersVC = FollowersListVC()
        let text = searchTextField.text ?? ""
        followersVC.username = text
        followersVC.title = text
        navigationController?.pushViewController(followersVC, animated: true)
    }
}

// MARK: - Setting Views
extension SearchVC {
    private func setupView() {
        view.backgroundColor = .systemBackground
        // TODO: Limit textfield to 39 characters
        searchTextField.delegate = self
        addSubViews()
        setupLayout()
        createDismissKeyboardTapGestureRecognizer()
    }
}

// MARK: - Setting
extension SearchVC {
    private func addSubViews() {
        imageLogoView.translatesAutoresizingMaskIntoConstraints = false
        imageLogoView.image = UIImage(resource: .whoFollowsText)
        imageLogoView.contentMode = .scaleAspectFit
        // Search button and it's action
        view.addSubview(searchButton)
        searchButton.addAction(UIAction { _ in self.pushFollowersListVC() }, for: .touchUpInside)
        view.addSubview(searchGroupVStack)
        searchGroupVStack.addArrangedSubview(imageLogoView)
        view.addSubview(searchRowHStack)
        searchGroupVStack.addArrangedSubview(searchRowHStack)
        searchRowHStack.addArrangedSubview(searchTextField)
        searchRowHStack.addArrangedSubview(searchButton)
    }
    private func createDismissKeyboardTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
}

// MARK: - Layout
extension SearchVC {
    private func setupLayout() {
        // MARK: - SearchTextField
        NSLayoutConstraint.activate([
            searchGroupVStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchGroupVStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            searchGroupVStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            searchGroupVStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
        ])
        // MARK: Fix button hugging and resistance priority
        searchTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        searchTextField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        searchButton.setContentHuggingPriority(.required, for: .horizontal)
        searchButton.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}

// MARK: - TextFieldDelegate
extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if searchTextField.text?.isEmpty ?? true {
            searchButton.isEnabled = false
        } else {
            searchButton.isEnabled = true
        }
    }
}

#Preview {
    SearchVC()
}
