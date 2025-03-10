//
//  UserInfoVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 18.02.2025.
//
// https://www.hackingwithswift.com/articles/118/uiactivityviewcontroller-by-example
//

import UIKit
import SafariServices

final class UserInfoVC: UIViewController, DataLoadingView {
    var containerView: UIView!
    
    // Collection View
    enum Section { case main }
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, UserTileData>!
    // MARK: - Private Property
    private var follower: Follower!
    private var user: User?
    private let networkManager = NetworkManager.shared
    private let coreDataController = CoreDataController.shared
    // MARK: - UI Elements
    private let userHeaderView = WFUserInfoHeaderVC()
    private let userFooterView = WFUserInfoFooterVC()
    private var userTileData = [UserTileData]()
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
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - UIBarButtons
extension UserInfoVC {
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    @objc func favoriteUser() {
        guard coreDataController.doesFollowerExist(login: follower.login) != true else {
            
            let message = "Follower \"\(follower.login)\" is already in your favorites list."
            presentWFAlert(title: WFAlertTitleMessages.userExists, message: message)
            return
            
        }
        
        Task {
            showLoadingView()
            await performAddFavorite()
            setupBarButtons()
            dismissLoadingView()
        }
        
    }
}
// MARK: - Logic
extension UserInfoVC {
    
    private func pushFollowersListVC() {
        let followersVC = FollowersListVC(login: follower.login)
        navigationController?.pushViewController(followersVC, animated: true)
    }
    private func pushFollowingListVC() {
        let followingVC = FollowingListVC(login: follower.login)
        navigationController?.pushViewController(followingVC, animated: true)
    }
    
    private func getUser() {
        showLoadingView()
        Task {
            do {
                let user = try await networkManager.makeUserRequest(for: follower.login)
                setUser(user)
                dismissLoadingView()
            } catch {
                // Setting self as a delegate since UserInfoVC will have to dismiss if the user is not found
                handleErrorResult(error: error, delegate: self)
            }
        }
    }
    
    private func setUser(_ user: User) {
        self.userHeaderView.setUser(user)
        self.setupTiles(with: user)
        self.userFooterView.setUser(user)
        self.user = user
    }
    
}
// MARK: - Setting Views
extension UserInfoVC {
    func setupView() {
        title = follower?.login
        userHeaderView.delegate = self
        setupBarButtons()
        setupCollectionView()
        setupDataSource()
        addSubViews()
    }
    private func setupBarButtons() {
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissVC)
        )
        var buttonIcon: WFSymbols = .addIcon
        if coreDataController.doesFollowerExist(login: follower.login) == true {
            buttonIcon = .checkmarkIcon
        }
        let addButton = UIBarButtonItem(
            image: buttonIcon.image,
            style: .plain,
            target: self,
            action: #selector(favoriteUser))
        if presentingViewController == nil {
            navigationItem.rightBarButtonItem = addButton
        } else {
            navigationItem.rightBarButtonItem = doneButton
            navigationItem.leftBarButtonItem = addButton
        }
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
            withReuseIdentifier: WFHeaderReusableView.reuseID
        )
        collectionView.register(
            WFFooterReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: WFFooterReusableView.reuseID
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
                    withReuseIdentifier: WFHeaderReusableView.reuseID,
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
                    withReuseIdentifier: WFFooterReusableView.reuseID,
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
        userTileData = [
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
                icon: .gistsIcon,
                value: user.publicGists.description
            ),
            UserTileData(
                title: "Repos",
                icon: .repositoriesIcon,
                value: user.publicRepos.description
            )
        ]
        updateSnapshot(with: userTileData)
    }
}
// MARK: - Collection View
extension UserInfoVC: UICollectionViewDelegateFlowLayout {
    // Header size
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: userHeaderView.getHeaderHeight())
        
    }
    // Footer size
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 70)
        
    }
    // Navigate on tap
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = userTileData[indexPath.item]
        if item.title == "Followers" {
            pushFollowersListVC()
        }
        
        if item.title == "Following" {
            pushFollowingListVC()
        }
        
    }
}

extension UserInfoVC: UserInfoHeaderDelegate {
    
    func didTapShareButton(for user: User) {
        let activityView = UIActivityViewController(
            activityItems: [user.htmlUrl],
            applicationActivities: nil
        )
        present(activityView, animated: true)
    }
    
    func didTapSafariButton(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentWFAlert(title: .invalidURL, message: "The URL attached to this user is invalid")
            return
        }
        presentSafariVC(with: url)
    }
    
}
// MARK: - Persistence
extension UserInfoVC {
    private func performAddFavorite() async {
        do {
            // Add follower
            try coreDataController.addFollower(follower)
            // Try to save the avatar image
            let image = await networkManager.downloadImage(fromURL: user?.avatarUrl ?? "")
            guard let image = image else { return }
            try image.saveToDisk(follower: follower)
        } catch {
            presentWFAlert(title: WFAlertTitleMessages.somethingWentWrong, message: error.localizedDescription)
        }
    }
}

extension UserInfoVC: WFAlertVCDelegate {
    func didTapButton() {
        // We dismiss modally presented viewControllers and we pop the ones pushed onto the STACK!
        navigationController?.popViewController(animated: true)
        // dismiss(animated: true) - for modally presented viewController (sheets)
    }
    
}

#Preview {
    UserInfoVC(follower: Follower(login: "killlilwinters", avatarUrl: "123.com"))
}
