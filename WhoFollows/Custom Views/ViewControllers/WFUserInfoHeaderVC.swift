//
//  WFUserInfoHeaderVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 20.02.2025.
//

import UIKit

final class WFUserInfoHeaderVC: UIViewController {
    // MARK: - Private Property
    private var user: User!
    // Labels
    private let usernameLabel = WFTitleLabel(textAlignment: .left, fontSize: 35)
    private let nameLabel = WFSecondaryTitleLabel(size: 20)
    private let locationLabel = WFBodyLabel(textAlignment: .left, numberOfLines: 1)
    private let bioLabel = WFBodyLabel(textAlignment: .justified, numberOfLines: 3)
    // Images
    private let avatarImageView = WFAvatarImageView(frame: .zero)
    private let locationImageView = UIImageView(
        image: UIImage(systemName: SFSymbols.locationMark)
    )
    // Stacks
    private let vStack = WFStack(axis: .vertical, spacing: 12, alignment: .leading)
    private let hStack = WFStack(axis: .horizontal, spacing: 5)
    // Collected subviews
    private var subviews: [UIView]!
    // MARK: - Initializers
    init(user: User!) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
        self.subviews = [
            avatarImageView,
            bioLabel,
            vStack,
            hStack
        ]
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avatarImageView.roundImage()
    }
}

// MARK: - Logic
extension WFUserInfoHeaderVC { }
// MARK: - Setting Views
extension WFUserInfoHeaderVC {
    private func setupView() {
        view.backgroundColor = .systemBackground
        addSubViews()
        setupLayout()
        setupUserInfo()
        setupImageViews()
    }
}

// MARK: - Setting
extension WFUserInfoHeaderVC {
    private func addSubViews() {
        subviews.forEach { view.addSubview($0) }
        hStack.addArrangedSubview(locationImageView)
        hStack.addArrangedSubview(locationLabel)
        [usernameLabel, nameLabel, hStack].forEach { vStack.addArrangedSubview($0) }
    }
    private func setupUserInfo() {
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.location ?? " -"
        bioLabel.text = user.bio ?? ""
    }
    private func setupImageViews() {
        // Avatar image view
        avatarImageView.downloadImage(from: user.avatarUrl)
        // Location systemImage view
        locationImageView.tintColor = .secondaryLabel
        locationImageView.contentMode = .scaleAspectFit
    }
}

// MARK: - Layout
extension WFUserInfoHeaderVC {
    private func setupLayout() {
        let padding: CGFloat = 20
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35),
            avatarImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35)
        ])
        NSLayoutConstraint.activate([
            vStack.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            vStack.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding)
        ])
        NSLayoutConstraint.activate([
            usernameLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.5)
        ])
        let paddingVertical = view.bounds.height / 25
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: paddingVertical),
            bioLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            bioLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

#Preview {
    WFUserInfoHeaderVC(user: killlilwinters)
}
