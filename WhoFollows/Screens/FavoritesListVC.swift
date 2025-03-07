//
//  FavoritesListVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 28.01.2025.
//

import UIKit

final class FavoritesListVC: UIViewController {
    // MARK: - Private Property
    private let coreDataController = CoreDataController.shared
    private let tableView = UITableView()
    private var favorites = [Follower]()
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getFavorites()
    }
}

// MARK: - Logic
extension FavoritesListVC {
    func getFavorites() {
        favorites = coreDataController.getAllFollowers().convertToFollowers()
        if favorites.isEmpty {
            let message = "You do not have any favorites yet :("
            self.displayEmptyStateView(with: message, in: self.view)
        } else {
            view.bringSubviewToFront(tableView)
            tableView.reloadData()
        }
    }
}
// MARK: - Setting Views
extension FavoritesListVC {
    func setupView() {
        view.backgroundColor = .systemBackground
        setupTableView()
    }
}

// MARK: - Setting
extension FavoritesListVC {
    func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = UIScreen.main.bounds.height / 10
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
}

// MARK: - Layout
extension FavoritesListVC { }

extension FavoritesListVC: TableViewDelegateMethods {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as? FavoriteCell else {
            fatalError("Could not dequeue tableView cell")
        }
        let favorite = favorites[indexPath.row]
        // Try to get image from caches directory
        if let image = try? UIImage.getFromDisk(login: favorite.login) {
            print("Got the image from disk")
            cell.set(with: favorite, image: image)
        } else {
            // Try to download instead
            print("Downloading the image")
            Task {
                if let image = await NetworkManager.shared.downloadImage(from: favorite.avatarUrl) {
                    try? image.saveToDisk(follower: favorite)
                    cell.set(with: favorite, image: image)
                } else {
                    cell.set(with: favorite, image: nil)
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let detailVC = UserInfoVC(follower: favorite)
        
        let navController = UINavigationController(rootViewController: detailVC)
        present(navController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favoriteToDelete = favorites[indexPath.row]
            do {
                try coreDataController.removeFollower(login: favoriteToDelete.login)
                try UIImage.removeFromDisk(login: favoriteToDelete.login)
            } catch {
                presentWFAlertVCOnMainThread(
                    title: .somethingWentWrong,
                    message: error.localizedDescription,
                    buttonTitle: "OK"
                )
                return
            }
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

#Preview {
    FavoritesListVC()
}
