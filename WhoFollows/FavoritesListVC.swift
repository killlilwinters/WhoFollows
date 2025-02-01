//
//  FavoritesListVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 28.01.2025.
//

import UIKit

final class FavoritesListVC: UIViewController {
    
    private let tempLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        tempLabel.text = "Favorites"
        tempLabel.textColor = .label
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tempLabel)
        
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }

}

#Preview {
    FavoritesListVC()
}
