//
//  FollowersListVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 01.02.2025.
//

import UIKit

final class FollowersListVC: UIViewController {
    var username: String!
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = username
        label.textColor = .label
        label.allowsDefaultTighteningForTruncation = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.inputViewController?.navigationItem.title = username
        // MARK: Testing
        let networkManager = NetworkManager.shared
        networkManager.getFollowers(for: username, page: 1) { result in
            switch result {
            case .success(let followers):
                print(followers)
            case .failure(let error):
                self.presentWFAlertVCOnMainThread(title: "Someting went wrong...",
                                                  message: error.rawValue,
                                                  buttonTitle: "OK")
            }
        }
        // MARK: Testing end
        addSubViews()
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
// MARK: - Logic
extension FollowersListVC {
}
// MARK: = Setting View
extension FollowersListVC {
}
// MARK: - Setting
extension FollowersListVC {
    func addSubViews() {
        view.addSubview(label)
    }
}

// MARK: - Layout
extension FollowersListVC {
    func setupLayout() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

#Preview {
    FollowersListVC()
}
