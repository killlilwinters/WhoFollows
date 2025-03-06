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
        
        networkManager.makeFollowersRequest(for: username, page: page) { [weak self] result in
            
            guard let self = self else { return }
            self.handleNetworkResult(result: result)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddButton()
    }
}

// MARK: -
extension FollowersListVC {
    
    private func setupAddButton() {
        var buttonIcon: WFSymbols = .addIcon
        if coreDataController.doesFollowerExist(login: username) == true {
            buttonIcon = .checkmarkIcon
        }
        guard presentingViewController == nil else { return }
        let addButton = UIBarButtonItem(
            image: buttonIcon.image,
            style: .plain,
            target: self,
            action: #selector(saveToFavorites))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func performAddFavorite(user: User) async {
        let follower = user.convertToFollower()
        
        do {
            let image = await networkManager.downloadImage(from: user.avatarUrl)
            try coreDataController.addFollower(follower, image: image)
        } catch {
            presentWFAlertVCOnMainThread(
                title: WFAlertTitleMessages.somethingWentWrong,
                message: error.localizedDescription,
                buttonTitle: "OK"
            )
        }
    }
    
    @objc private func saveToFavorites() {
        // Check if the user is already in the database
        guard coreDataController.doesFollowerExist(login: username) != true else {
            presentWFAlertVCOnMainThread(
                title: WFAlertTitleMessages.userExists,
                message: "Follower \"\(username ?? "")\" is already in your favorites list.",
                buttonTitle: "OK"
            )
            return
        }
        
        // If the user is not in the database - start the network call
        showLoadingView()
        
        networkManager.makeUserRequest(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                // Use task to ensure all async code and UI updates run in order
                Task {
                    await self.performAddFavorite(user: user)
                    self.dismissLoadingView()
                    self.setupAddButton()
                }
            case .failure(let error):
                self.presentWFAlertVCOnMainThread(
                    title: .somethingWentWrong,
                    message: error.localizedDescription,
                    buttonTitle: "OK"
                )
            }
        }
    }
    
}

#Preview {
    let followersListVC = FollowersListVC()
    followersListVC.username = "killlilwinters"
    return followersListVC
}
