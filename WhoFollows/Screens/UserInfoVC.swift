//
//  UserInfoVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 18.02.2025.
//

import UIKit

final class UserInfoVC: UIViewController {
    var bounds: CGRect = .zero
    // MARK: - Private Property
    private var user: User?
    private let headerView = UIView()
    private var follower: Follower!
    private let networkManager = NetworkManager.shared
    // Collection View
    enum Section { case main }
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, UserInfoPiece>!
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
            case .success(let user): break
//                DispatchQueue.main.async {
//                    self.add(childVC: WFUserInfoHeaderVC(user: user), to: self.headerView)
//                }
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
        updateSnapshot(with: [
            userInfoPiece
        ])
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
        collectionView.register(UserInfoCell.self, forCellWithReuseIdentifier: UserInfoCell.reuseId)
        collectionView.register(
            WFHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: WFHeaderReusableView.reuseId
        )
    }
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, UserInfoPiece>(
            collectionView: collectionView
        ) { collectionView, indexPath, userInfoPiece in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: UserInfoCell.reuseId,
                for: indexPath
            ) as? UserInfoCell else {
                fatalError("Could not create a new cell for User")
            }
            cell.set(userInfoPiece: userInfoPiece)
            return cell
        }
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: WFHeaderReusableView.reuseId,
                for: indexPath
            ) as? WFHeaderReusableView else {
                fatalError("Could not dequeue WFHeaderReusableView")
            }
            header.addChildVC(childVC: WFUserInfoHeaderVC(user: killlilwinters), parentVC: self)
            return header
        }
    }
    private func updateSnapshot(with newUserInfoPieces: [UserInfoPiece]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UserInfoPiece>()
        snapshot.appendSections([.main])
        snapshot.appendItems(newUserInfoPieces, toSection: .main)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

// MARK: - Layout
extension UserInfoVC { }
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
}
#Preview {
    UserInfoVC(follower: Follower(login: "123", avatarUrl: "123.com"))
}
