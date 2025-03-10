//
//  WFUserInfoHeaderVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 20.02.2025.
//

import UIKit

protocol UserInfoHeaderDelegate: AnyObject {
    func didTapShareButton(for user: User)
    func didTapSafariButton(for user: User)
}

final class WFUserInfoHeaderVC: UIViewController {
    // MARK: - Private Property
    private var user: User?
    weak var delegate: UserInfoHeaderDelegate!
    // Labels
    private let usernameLabel = WFTitleLabel(textAlignment: .left, fontSize: 35)
    private let nameLabel = WFSecondaryTitleLabel(fontSize: 20)
    private let locationLabel = WFBodyLabel(textAlignment: .left, numberOfLines: 1)
    private let bioLabel = WFBodyLabel(textAlignment: .justified, numberOfLines: 3)
    // Images
    private let avatarImageView = WFAvatarImageView(frame: .zero)
    private let locationImageView = UIImageView(
        image: WFSymbols.locationMarkIcon.image
    )
    // Stacks
    private let vStack = WFStack(axis: .vertical, spacing: 12, alignment: .leading)
    private let hStack = WFStack(axis: .horizontal, spacing: 5)
    private let buttonHStack = WFStack(axis: .horizontal, spacing: 12)
    // Share and Open buttons
    private let shareButton = WFGenericButtonVC(
        text: "Share",
        color: .systemOrange,
        image: WFSymbols.shareIcon.image,
        configType: .borderedTinted()
    )
    private let safariButton = WFGenericButtonVC(
        text: "Open",
        color: .systemOrange,
        image: WFSymbols.safariIcon.image,
        configType: .borderedTinted()
    )
    // Custom subviews
    private let separator = WFSeparatorView(frame: .zero)
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
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
    
    func setUser(_ user: User) {
        self.user = user
        setupUserInfo()
    }
    
}

// MARK: - Logic
extension WFUserInfoHeaderVC {
    
    func shareButtonAction() {
        guard let user else { return }
        delegate.didTapShareButton(for: user)
    }
    
    func safariButtonAction() {
        guard let user else { return }
        delegate.didTapSafariButton(for: user)
    }
    
}
// MARK: - Setting Views
extension WFUserInfoHeaderVC {
    private func setupView() {
        view.backgroundColor = .systemBackground
        addSubViews()
        setupLayout()
        setupUserInfo()
        setupLocationImageView()
        setupButtons()
    }
}

// MARK: - Setting
extension WFUserInfoHeaderVC {
    
    private func addSubViews() {
        view.addSubviews(
            avatarImageView,
            bioLabel,
            separator,
            vStack,
            hStack,
            buttonHStack
        )
        hStack.addArrangedSubviews(locationImageView, locationLabel)
        vStack.addArrangedSubviews(usernameLabel, nameLabel, hStack)
        buttonHStack.addArrangedSubviews()
        buttonHStack.addArrangedSubview(shareButton)
        buttonHStack.addArrangedSubview(safariButton)
    }
    private func setupUserInfo() {
        usernameLabel.text = user?.login ?? "No content..."
        nameLabel.text = user?.name ?? "This user hasn't set a name."
        locationLabel.text = user?.location ?? " -"
        bioLabel.text = user?.bio ?? "This user hasn't set a bio."
        avatarImageView.downloadImage(fromURL: user?.avatarUrl ?? "")
    }
    private func setupLocationImageView() {
        locationImageView.tintColor = .secondaryLabel
        locationImageView.contentMode = .scaleAspectFit
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setupButtons() {
        shareButton.addAction(UIAction { _ in self.shareButtonAction() }, for: .touchUpInside)
        safariButton.addAction(UIAction { _ in self.safariButtonAction() }, for: .touchUpInside)
    }
    
}

// MARK: - Layout
extension WFUserInfoHeaderVC {
    
    func getHeaderHeight() -> CGFloat {
        view.layoutIfNeeded()
        let totalHeight = [avatarImageView, bioLabel, shareButton, separator]
            .reduce(into: 0) { $0 += $1.frame.height }
        return totalHeight + 90
    }
    
    private func setupLayout() {
        let padding: CGFloat = 20
        let paddingVertical = view.bounds.height / 25
        let widthConstraintMultiplier: CGFloat = 0.9
        
        // avatarImageView
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35),
            avatarImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35),
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding)
        ])
        // vStack
        NSLayoutConstraint.activate([
            vStack.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            vStack.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding)
        ])
        // Labels
        NSLayoutConstraint.activate([
            usernameLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.5),
            nameLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.5),
            locationLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.5)
        ])
        // bioLabel
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: paddingVertical),
            bioLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthConstraintMultiplier),
            bioLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        // buttonHStack
        NSLayoutConstraint.activate([
            buttonHStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthConstraintMultiplier),
            buttonHStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonHStack.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: padding)
        ])
        // separator
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: buttonHStack.bottomAnchor, constant: padding),
            separator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separator.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthConstraintMultiplier)
        ])
        
    }
}

#Preview {
    let headerView = WFUserInfoHeaderVC()
    headerView.setUser(killlilwinters)
    return headerView
}
