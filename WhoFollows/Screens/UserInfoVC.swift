//
//  UserInfoVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 18.02.2025.
//

import UIKit

final class UserInfoVC: UIViewController {
    // MARK: - Private Property
    private var follower: Follower?
    // MARK: - UI Elements
    // MARK: - Initializers
    init(follower: Follower) {
        super.init(nibName: nil, bundle: nil)
        self.follower = follower
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
extension UserInfoVC {
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    func pushFollowersListVC() {
    }
}
// MARK: - Setting Views
extension UserInfoVC {
    func setupView() {
        view.backgroundColor = .systemBackground
        title = follower?.login
        setupDoneButton()
        addSubViews()
        setupLayout()
    }
    func setupDoneButton() {
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissVC)
        )
        navigationItem.rightBarButtonItem = doneButton
    }
}

// MARK: - Setting
extension UserInfoVC {
    func addSubViews() {
    }
}

// MARK: - Layout
extension UserInfoVC {
    func setupLayout() {
        NSLayoutConstraint.activate([])
    }
}
