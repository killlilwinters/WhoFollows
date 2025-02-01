//
//  CustomButtonExtension.swift
//  WhoFollows
//
//  Created by Maks Winters on 28.01.2025.
//
// https://stackoverflow.com/questions/68328038/imageedgeinsets-was-deprecated-in-ios-15-0
//

import UIKit

extension UIButton {
    static func makeCustomButton(
        title: String?,
        systemImage: String,
        style: UIButton.Configuration.CornerStyle = .medium,
        imagePlacement: NSDirectionalRectEdge = .leading,
        color: UIColor = .systemBlue) -> UIButton {
        
        var config = UIButton.Configuration.filled()
        if let title = title {
            config.title = title
        }
        config.image = UIImage(systemName: systemImage)
        config.cornerStyle = style
        config.imagePlacement = imagePlacement
        config.imagePadding = 8
        config.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        config.baseBackgroundColor = color
            config.baseForegroundColor = .white
        let button = UIButton(configuration: config)
        return button
        
    }
}


#Preview {
    UIButton.makeCustomButton(title: "Test button", systemImage: "arrow.forward.circle", imagePlacement: .trailing, color: .systemGreen)
}
