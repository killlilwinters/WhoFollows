//
//  UserInfoVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 18.02.2025.
//

import UIKit

final class UserInfoVC: UIViewController {
    // Collection View
    enum Section { case main }
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, UserTileData>!
    // MARK: - Private Property
    private var follower: Follower!
    private let networkManager = NetworkManager.shared
    // MARK: - UI Elements
    private let userHeaderView = WFUserInfoHeaderVC()
    private let userFooterView = WFUserInfoFooterVC()
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
#if DEBUG
// MARK: - DEBUG
extension UserInfoVC {
    func setUser(_ user: User) {
        self.userHeaderView.setUser(user)
        self.setupTiles(with: user)
        self.userFooterView.setUser(user)
    }
}
#endif
// MARK: - UIBarButtons
extension UserInfoVC {
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    @objc func favoriteUser() {
        // TODO: Implement
    }
}
// MARK: - Logic
extension UserInfoVC {
    func getUser() {
        networkManager.makeRequest(for: follower.login) { [weak self] (result: Result<User, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let user):
// #if !DEBUG
                DispatchQueue.main.async {
                    self.userHeaderView.setUser(user)
                    self.setupTiles(with: user)
                    self.userFooterView.setUser(user)
                }
// #endif
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
        title = follower?.login
        setupDoneButton()
        setupCollectionView()
        setupDataSource()
        addSubViews()
    }
    private func setupDoneButton() {
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
        view.addSubview(collectionView)
    }
    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout().setupCustomFlowLayout(
            numOfColumns: 2,
            view: view
        )
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: flowLayout
        )
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(UserInfoTileCell.self, forCellWithReuseIdentifier: UserInfoTileCell.reuseId)
        collectionView.register(
            WFHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: WFHeaderReusableView.reuseId
        )
        collectionView.register(
            WFFooterReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: WFFooterReusableView.reuseId
        )
    }
    private func setupDataSource() {
        // Setting up cells
        dataSource = UICollectionViewDiffableDataSource<Section, UserTileData>(
            collectionView: collectionView
        ) { collectionView, indexPath, userInfoPiece in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: UserInfoTileCell.reuseId,
                for: indexPath
            ) as? UserInfoTileCell else {
                fatalError("Could not create a new cell for User")
            }
            cell.set(userInfoPiece: userInfoPiece)
            return cell
        }
        // Setting up the header view
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let self = self else { fatalError("Error creating the header view") }
            // Dequeue Header
            if kind == UICollectionView.elementKindSectionHeader {
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: WFHeaderReusableView.reuseId,
                    for: indexPath
                ) as? WFHeaderReusableView else {
                    fatalError("Could not dequeue WFHeaderReusableView as the header")
                }
                header.addChildVC(childVC: self.userHeaderView, parentVC: self)
                return header
            }
            // Dequeue Footer
            if kind == UICollectionView.elementKindSectionFooter {
                guard let footer = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: WFFooterReusableView.reuseId,
                    for: indexPath
                ) as? WFFooterReusableView else {
                    fatalError("Could not dequeue WFFooterReusableView as the footer")
                }
                footer.addChildVC(childVC: self.userFooterView, parentVC: self)
                return footer
            }
            return nil
        }
    }
    private func updateSnapshot(with newUserInfoPieces: [UserTileData]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UserTileData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(newUserInfoPieces, toSection: .main)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

// MARK: - Setting CollectionView tiles
extension UserInfoVC {
    private func setupTiles(with user: User) {
        let tiles = [
            UserTileData(
                title: "Followers",
                subtitle: "See more",
                icon: .followersCountIcon,
                value: user.followers.description,
                tileColor: UIColor.systemPink.withAlphaComponent(0.6)
            ),
            UserTileData(
                title: "Following",
                subtitle: "See more",
                icon: .followingCountIcon,
                value: user.following.description,
                tileColor: UIColor.systemGreen.withAlphaComponent(0.6)
            ),
            UserTileData(
                title: "Gists",
                icon: .followersCountIcon,
                value: user.publicGists.description
            ),
            UserTileData(
                title: "Repos",
                icon: .repositoriesIcon,
                value: user.publicRepos.description
            )
        ]
        updateSnapshot(with: tiles)
    }
}
// MARK: - Collection View
extension UserInfoVC: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        let screenHeight = UIScreen.main.bounds.height
        let headerHeight = max(180, min(screenHeight * 0.36, 265))
        return CGSize(width: collectionView.bounds.width, height: headerHeight)
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 70)
    }
}

#Preview {
    let userInfoVC = UserInfoVC(follower: Follower(login: "killlilwinters", avatarUrl: "123.com"))
    userInfoVC.setUser(killlilwinters)
    return userInfoVC
}
