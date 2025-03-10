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
        
        NetworkManager.shared.makeFollowingRequest(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.handleNetworkResult(result: result)
        }
    }
    
}
