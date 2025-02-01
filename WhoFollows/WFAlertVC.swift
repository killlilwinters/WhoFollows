//
//  WFAlertVC.swift
//  WhoFollows
//
//  Created by Maks Winters on 01.02.2025.
//

import UIKit

class WFAlertVC: UIViewController {
    
    let containerView = UIView()
    let titleLabel = WFTitleLabel(textAlignment: .center, fontSize: 30)
    let messageLabel = WFBodyLabel(textAlignment: .center)
    let button = WFGenericButtonVC(text: "OK", color: .systemOrange)
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    init(alertTitle: String? = nil, message: String? = nil, buttonTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var vStack: UIStackView = WFStack(axis: .vertical, spacing: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        containerView.backgroundColor = .alertBackground
        containerView.layer.cornerRadius = 20
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.4
        containerView.layer.shadowRadius = 8
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        titleLabel.text = alertTitle
        
        view.addSubview(vStack)
        vStack.alignment = .center
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(messageLabel)
        containerView.addSubview(button)
        
        messageLabel.text = message
        containerView.addSubview(vStack)
        
        
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22)
        ])
        
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            vStack.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            vStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            button.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
        
    }

}

#Preview {
    WFAlertVC(alertTitle: "Error occured!", message: "Something went wrong!")
}
