//
//  SearchVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 28.01.2025.
//

import UIKit

final class SearchVC: UIViewController {
    
    //MARK: - Private Property
    private let searchTextField: UITextField = WFTextField(icon: UIImage(systemName: "person"), placeholder: "Search a user")
    
    private let searchButton: UIButton = UIButton.makeCustomButton(title: "Search", systemImage: "magnifyingglass")
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.backgroundColor = .systemBackground
    }

}
//MARK: - Setting Views
extension SearchVC {
    func setupView() {
        
        addSubViews()
        
        setupLayout()
    }
}

//MARK: - Setting
extension SearchVC {
    func addSubViews() {
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
    }
}

//MARK: - Layout
extension SearchVC {
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            
        ])
        
    }
}

#Preview {
    SearchVC()
}
