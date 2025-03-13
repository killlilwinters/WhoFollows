//
//  BaseUserListVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 02.03.2025.
//

import UIKit

class BaseUserListVC: UIViewController, DataLoadingView {
    // MARK: - DiffableDS Enum
    enum Section { case main }
    
    // Network Manager
    let networkManager = NetworkManager.shared
    
    // Conform to DataLoadingView
    var containerView: UIView!
    
    // MARK: - Properties
    var username: String!
    var page = 1
    private var hasMoreFollowers = true
    
    // Followers and filtering
    private var isFiltering = false
    private var isLoadingMoreFollowers = false
    private var followers = [Follower]()
    private var filteredFollowers = [Follower]()
    
    // MARK: - Inits
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    // MARK: - Initializer
    init(login: String) {
        self.username = login
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        title = username + "'s followers"
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func getContent() {
        showLoadingView()
        isLoadingMoreFollowers = true
        
        Task {
            do {
                let followers = try await networkManager.makeFollowersRequest(for: username, page: page)
                handleNetworkResult(with: followers)
            } catch {
                handleErrorResult(error: error)
            }
        }
        isLoadingMoreFollowers = false
    }
    
    func handleNetworkResult(with followers: [Follower]) {
        dismissLoadingView()
        checkIfHasMoreFollowers(followers)
        
        self.followers.append(contentsOf: followers)
        updateSnapshot(with: followers)
        
        checkIfHasFollowers(followers)
    }
    
}
// MARK: - Logic
extension BaseUserListVC {
    @MainActor
    private func checkIfHasFollowers(_: [Follower]) {
        if self.followers.isEmpty {
            let message = "This user doesn't seem to have any followers yet..."
            self.displayEmptyStateView(with: message, in: self.view)
        }
    }
    private func checkIfHasMoreFollowers(_ followers: [Follower]) {
        if followers.count < networkManager.followersPerPage {
            self.hasMoreFollowers = false
        }
    }
}
// MARK: - Setting View
extension BaseUserListVC {
    func setupView() {
        // Display followers setup (has to go first)
        setupCollectionView()
        setupDataSource()
        view.backgroundColor = .systemBackground
        getContent()
        setupSearchController()
        addSubViews()
    }
}
// MARK: - Setting
extension BaseUserListVC {
    private func addSubViews() {
        view.addSubview(collectionView)
    }
    private func setupCollectionView() {
        // FlowLayout
        let flowLayout = UICollectionViewFlowLayout().setupCustomFlowLayout(
            numOfColumns: 2,
            addToHeight: 50,
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
    private func updateSnapshot(with newFollowers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        
        DispatchQueue.main.async {
            if self.isFiltering {
                snapshot.appendItems(newFollowers)
            } else {
                snapshot.appendItems(self.followers)
            }
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
// MARK: - Collection view delegate
extension BaseUserListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        if offsetY + frameHeight >= contentHeight {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getContent()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Getting the item
        let currentArray = isFiltering ? filteredFollowers : followers
        let follower = currentArray[indexPath.item]
        // Displaying the userinfo screen
        let detailVC = UserInfoVC(follower: follower)
        let navController = UINavigationController(rootViewController: detailVC)
        present(navController, animated: true)
    }
    
}
// MARK: - Search Controller Setup
extension BaseUserListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            isFiltering = false
            self.dismissEmptyStateView(from: self.view)
            updateSnapshot(with: followers)
            return
        }
        isFiltering = true
        filteredFollowers = followers.filter {
            return $0.login.localizedStandardContains(filter)
        }
        if filteredFollowers.isEmpty {
            self.displayEmptyStateView(with: "No followers for \"\(filter)\"", in: self.view)
        } else {
            self.dismissEmptyStateView(from: self.view)
        }
        updateSnapshot(with: filteredFollowers)
    }
    
    func setupSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search followers..."
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.searchController = searchController
    }
    
}

#Preview {
    BaseUserListVC(login: "killlilwinters")
}
