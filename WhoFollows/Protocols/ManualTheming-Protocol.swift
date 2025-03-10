//
//  ManualTheming-Protocol.swift
//  WhoFollows
//
//  Created by Maks Winters on 14.02.2025.
//
// https://stackoverflow.com/a/77475479
//

import UIKit

protocol ManualTheming: AnyObject {
    func updateAppearance()
}

extension ManualTheming where Self: UIView {
    @MainActor
    func registerForApperanceChanges() {
        self.registerForTraitChanges(
            [UITraitUserInterfaceStyle.self],
            
            handler: { (self: Self, _: UITraitCollection) in
                self.updateAppearance()
            }
            
        )
    }
}

extension ManualTheming where Self: UIViewController {
    @MainActor
    func registerForApperanceChanges() {
        self.registerForTraitChanges(
            [UITraitUserInterfaceStyle.self],
            
            handler: { (self: Self, _: UITraitCollection) in
                self.updateAppearance()
            }
            
        )
    }
}
