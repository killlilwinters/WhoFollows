//
//  FollowingListVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 28.02.2025.
//

import Foundation
import UIKit

class FollowingListVC: BaseUserListVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = username + "'s following"
    }
    
    override func getContent() {
        showLoadingView()
        Task {
            let followers = try await networkManager.makeFollowingRequest(for: username, page: page)
            handleNetworkResult(with: followers)
        }
    }
    
}
