//
//  SearchVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 28.01.2025.
//

import UIKit

final class SearchVC: UIViewController {
    
    //MARK: - Private Property
    
    private let imageLogoView = UIImageView()
    
    private let searchTextField: UITextField = WFTextField(icon: UIImage(systemName: "person"), placeholder: "Search a user")
    
    private let searchButton: UIButton = WFSearchButton()
    
    private var searchGroupVStack: UIStackView = {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
        
    }()
    
    private var searchRowHStack: UIStackView = {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
        
    }()
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
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
        imageLogoView.translatesAutoresizingMaskIntoConstraints = false
        imageLogoView.image = UIImage(resource: .whoFollowsText)
        imageLogoView.contentMode = .scaleAspectFit
        
        view.addSubview(searchButton)
        
        view.addSubview(searchGroupVStack)
        searchGroupVStack.addArrangedSubview(imageLogoView)
        view.addSubview(searchRowHStack)
        searchGroupVStack.addArrangedSubview(searchRowHStack)
        searchRowHStack.addArrangedSubview(searchTextField)
        searchRowHStack.addArrangedSubview(searchButton)
    }
}

//MARK: - Layout
extension SearchVC {
    func setupLayout() {
        
        //MARK: - SearchTextField
        NSLayoutConstraint.activate([
            searchGroupVStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchGroupVStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchGroupVStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            searchGroupVStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
        ])
        
    }
}

#Preview {
    SearchVC()
}
