//
//  FollowersListVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 01.02.2025.
//

import UIKit

class FollowersListVC: BaseUserListVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = username + "'s followers"
    }
    
    override func getContent() {
        showLoadingView()
        
        NetworkManager.shared.makeFollowersRequest(for: username, page: page) { [weak self] result in
            
            guard let self = self else { return }
            self.handleNetworkResult(result: result)
            
        }
    }
}

#Preview {
    let followersListVC = FollowersListVC()
    followersListVC.username = "killlilwinters"
    return followersListVC
}
