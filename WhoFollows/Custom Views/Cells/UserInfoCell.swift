//
//  UserInfoCell.swift
//  WhoFollows
//
//  Created by Maks Winters on 21.02.2025.
//

import UIKit

final class UserInfoCell: UICollectionViewCell {
    // MARK: - Static properties
    static let reuseId = "UserInfoCell"
    // MARK: - Private properties
    // MARK: - Private subviews
    private let imageView = UIImageView()
    private let valueLabel = WFTitleLabel(textAlignment: .left, fontSize: 50)
    private let titleLabel = WFTitleLabel(textAlignment: .left, fontSize: 25)
    private let subtitleLabel = WFSecondaryTitleLabel(fontSize: 20)
    private let vStack = WFStack(axis: .vertical, spacing: 20, alignment: .leading)
    private let hStack = WFStack(axis: .horizontal, spacing: 10, alignment: .center)
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        registerForApperanceChanges()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func set(userInfoPiece: UserInfoPiece) {
        // Image
        imageView.image = userInfoPiece.icon
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemOrange
        imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        // Rest
        valueLabel.text = userInfoPiece.value
        titleLabel.text = userInfoPiece.title
        subtitleLabel.text = userInfoPiece.subtitle
    }
}

// MARK: - Setting Views
extension UserInfoCell {
    private func setupCell() {
        layer.cornerRadius = 30
        layer.backgroundColor = UIColor(resource: .followerCellBackground).cgColor
        addSubViews()
        setupLayout()
    }
}

// MARK: - Setting
extension UserInfoCell {
    private func addSubViews() {
//        addSubview(imageView)
        addSubview(vStack)
        addSubview(hStack)
        [valueLabel, imageView].forEach {
            hStack.addArrangedSubview($0)
        }
        [hStack, titleLabel, subtitleLabel].forEach {
            vStack.addArrangedSubview($0)
        }
    }
}

// MARK: - Layout
extension UserInfoCell {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            hStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7)
        ])
        NSLayoutConstraint.activate([
            subtitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
    }
}
// MARK: - Listen to theme change
extension UserInfoCell: ManualTheming {
    func updateAppearance() {
        layer.backgroundColor = UIColor(resource: .followerCellBackground).cgColor
    }
}

#Preview {
    let view = UserInfoCell()
    view.set(userInfoPiece: userInfoPiece)
    return view
}
