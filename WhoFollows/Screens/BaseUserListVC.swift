//
//  BaseUserListVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 02.03.2025.
//
import UIKit

class BaseUserListVC: UIViewController, DataLoadingView {
    // MARK: DiffableDS Enum
    enum Section { case main }
    
    // Network Manager
    private let networkManager = NetworkManager.shared
    
    // Conform to DataLoadingView
    var containerView: UIView!
    
    // MARK: Properties
    var username: String!
    var page = 1
    private var hasMoreFollowers = true
    
    // Followers and filtering
    private var isFiltering = false
    private var followers = [Follower]()
    private var filteredFollowers = [Follower]()
    
    // MARK: Inits
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    // MARK: ViewDidLoad
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
        
        networkManager.makeFollowersRequest(for: username, page: page) { [weak self] result in
            
            guard let self = self else { return }
            self.handleNetworkResult(result: result)
            
        }
    }
    
    func handleNetworkResult(result: Result<[Follower], NetworkError>) {
        self.dismissLoadingView()
        switch result {
        case .success(let followers):
            checkIfHasMoreFollowers(followers)
            self.followers.append(contentsOf: followers)
            self.updateSnapshot(with: followers)
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
// MARK: - Logic
extension BaseUserListVC {
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
extension BaseUserListVC {
    func setupView() {
        // Display followers setup (has to go first)
        setupCollectionView()
        setupDataSource()
        
        view.backgroundColor = .systemBackground
//        view.inputViewController?.navigationItem.title = username
        setupAddButton()
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
        }
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    private func setupAddButton() {
        guard presentingViewController == nil else { return }
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addToFavorites)
        )
        navigationItem.rightBarButtonItem = addButton
    }
    @objc private func addToFavorites() {
        #warning("Implement me")
        print("Add button tapped")
    }
}
// MARK: - Collection view delegate
extension BaseUserListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        if offsetY + frameHeight >= contentHeight {
            guard hasMoreFollowers else { return }
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
extension BaseUserListVC: SearchControllerMethods {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            return
        }
        isFiltering = true
        filteredFollowers = followers.filter {
            return $0.login.containsCaseInsensitive(filter)
        }
        updateSnapshot(with: filteredFollowers)
    }
    func setupSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search followers..."
        navigationItem.searchController = searchController
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        updateSnapshot(with: followers)
    }
}

#Preview {
    let baseUserListVC = BaseUserListVC()
    baseUserListVC.username = "killlilwinters"
    return baseUserListVC
}
