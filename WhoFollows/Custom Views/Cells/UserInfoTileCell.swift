//
//  UserInfoTileCell.swift
//  WhoFollows
//
//  Created by Maks Winters on 21.02.2025.
//

import UIKit

final class UserInfoTileCell: UICollectionViewCell {
    // MARK: - Static properties
    static let reuseId = "UserInfoCell"
    // MARK: - Private properties
    // Make sure this is UIColor, since .cgColor seems to snapshot only a single
    // color so it will not change upon calling updateAppearance()
    // we should keep this property as UIColor and call .cgColor afterwards
    // right before passing the value into a property or a parameter that requires CGColor
    // just see updateAppearance()
    private var tileColor: UIColor = UIColor(resource: .followerCellBackground)
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
    func set(userInfoPiece: UserTileData) {
        // Image
        imageView.image = userInfoPiece.icon
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.label
        imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        // Rest
        valueLabel.text = userInfoPiece.value
        titleLabel.text = userInfoPiece.title
        subtitleLabel.text = userInfoPiece.subtitle
        // Tile view setting
        tileColor = userInfoPiece.tileColor
        updateAppearance()
    }
}

// MARK: - Additional Settings
extension UserInfoTileCell {
    private func setAdditionalSettings() {
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.minimumScaleFactor = 0.5
    }
}

// MARK: - Setting Views
extension UserInfoTileCell {
    private func setupCell() {
        layer.cornerRadius = 30
        layer.backgroundColor = tileColor.cgColor
        addSubViews()
        setupLayout()
        setAdditionalSettings()
    }
}

// MARK: - Setting
extension UserInfoTileCell {
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
extension UserInfoTileCell {
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
        NSLayoutConstraint.activate([
            valueLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -20)
        ])
    }
}
// MARK: - Listen to theme change
extension UserInfoTileCell: ManualTheming {
    func updateAppearance() {
        layer.backgroundColor = tileColor.cgColor
    }
}

#Preview {
    let view = UserInfoTileCell()
    view.set(userInfoPiece: userInfoPieceExample)
    return view
}
