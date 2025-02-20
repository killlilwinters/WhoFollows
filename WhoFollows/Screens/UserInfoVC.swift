//
//  UserInfoVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 18.02.2025.
//

import UIKit

final class UserInfoVC: UIViewController {
    // MARK: - Private Property
    private let headerView = UIView()
    private var follower: Follower!
    private let networkManager = NetworkManager.shared
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
        getUser()
        setupView()
    }
}

// MARK: - Logic
extension UserInfoVC {
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    func getUser() {
        networkManager.makeRequest(for: follower.login) { [weak self] (result: Result<User, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: WFUserInfoHeaderVC(user: user), to: self.headerView)
                }
            case .failure(let error):
                presentWFAlertVCOnMainThread(
                    title: "Something went wrong...",
                    message: error.rawValue,
                    buttonTitle: "OK"
                )
            }
        }
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
        view.addSubview(headerView)
    }
}

// MARK: - Layout
extension UserInfoVC {
    func setupLayout() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

#Preview {
    UserInfoVC(follower: Follower(login: "123", avatarUrl: "123.com"))
}
