//
//  FollowersListVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 01.02.2025.
//

import UIKit

final class FollowersListVC: UIViewController, DataLoadingView {
    // Conform to DataLoadingView
    var containerView: UIView!
    // MARK: DiffableDS Enum
    enum Section {
        case main
    }
    // MARK: Properties
    private let networkManager = NetworkManager.shared
    var username: String!
    private var page = 1
    private var hasMoreFollowers = true
    private var followers = [Follower]()
    // MARK: Inits
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    // MARK: Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Display followers setup (has to go first)
        setupCollectionView()
        setupDataSource()
        getFollowers()
        // Setup
        setupView()
        addSubViews()
        // setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
// MARK: - Logic
extension FollowersListVC {
    private func getFollowers() {
        showLoadingView()
        networkManager.getFollowers(for: username, page: page) { [weak self] result in
            // Check if self is nil
            guard let self = self else { return }
                self.dismissLoadingView()
            switch result {
            case .success(let followers):
                checkIfHasMoreFollowers(followers)
                self.appendToSnapshot(followers: followers)
                checkIfHasFollowers(followers)
            case .failure(let error):
                self.presentWFAlertVCOnMainThread(
                    title: "Something went wrong...",
                    message: error.rawValue,
                    buttonTitle: "OK"
                )
            }
        }
    }
    private func checkIfHasFollowers(_: [Follower]) {
        if self.followers.isEmpty {
            let message = "This user doesn't seem to have any followers yet..."
            DispatchQueue.main.async {
                self.displayEmptyStateView(with: message, in: self.view)
            }
        }
    }
    private func checkIfHasMoreFollowers(_ followers: [Follower]) {
        if followers.count < networkManager.followersPerPage {
            self.hasMoreFollowers = false
        }
    }
}
// MARK: - Setting View
extension FollowersListVC {
    func setupView() {
        view.backgroundColor = .systemBackground
        view.inputViewController?.navigationItem.title = username
    }
}
// MARK: - Setting
extension FollowersListVC {
    private func addSubViews() {
        view.addSubview(collectionView)
    }
    private func setupCollectionView() {
        // FlowLayout
        let flowLayout = UICollectionViewFlowLayout().setupCustomFlowLayout(
            numOfColumns: 2,
            view: view
        )
        // Collection View
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: flowLayout
        )
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(
            collectionView: collectionView
        ) { collectionView, indexPath, follower in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FollowerCell.reuseId,
                for: indexPath
            ) as? FollowerCell else {
                fatalError("Could not create new cell")
            }
            cell.set(follower: follower)
            return cell
        }
    }
    private func appendToSnapshot(followers newFollowers: [Follower]) {
        followers.append(contentsOf: newFollowers)
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
}
// MARK: - Collection view delegate
extension FollowersListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        if offsetY + frameHeight >= contentHeight {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers()
        }
    }
}

#Preview {
    FollowersListVC()
}
