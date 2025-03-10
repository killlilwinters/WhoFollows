//
//  FollowersListVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 01.02.2025.
//

import UIKit

class FollowersListVC: BaseUserListVC {
    
    let coreDataController = CoreDataController.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = username + "'s followers"
    }
    
    override func getContent() {
        showLoadingView()
        Task {
            let followers = try await networkManager.makeFollowersRequest(for: username, page: page)
            handleNetworkResult(with: followers)
        }
    }
}

// MARK: - Favorites persistence
extension FollowersListVC {
    
    private func performAddFavorite(user: User) async {
        let follower = user.convertToFollower()
        
        do {
            // Add follower
            try coreDataController.addFollower(follower)
            // Try to save the avatar image
            let image = await networkManager.downloadImage(fromURL: user.avatarUrl)
            guard let image else { return }
            try image.saveToDisk(follower: follower)
        } catch {
            handleErrorResult(error: error)
        }
    }
    
    @objc private func saveToFavorites() {
        // Check if the user is already in the database
        guard coreDataController.doesFollowerExist(login: username) != true else {
            
            let message = "Follower \"\(username ?? "")\" is already in your favorites list."
            presentWFAlert(title: WFAlertTitleMessages.userExists, message: message)
            return
            
        }
        // If the user is not in the database - start the network call
        showLoadingView()
        Task {
            do {
                let user = try await networkManager.makeUserRequest(for: username)
                await self.performAddFavorite(user: user)
                self.dismissLoadingView()
            } catch {
                handleErrorResult(error: error)
            }
        }
    }
    
}

#Preview {
    FollowersListVC(login: "killlilwinters")
}
