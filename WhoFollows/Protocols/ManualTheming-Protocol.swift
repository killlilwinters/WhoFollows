//
//  ManualTheming-Protocol.swift
//  WhoFollows
//
//  Created by Maks Winters on 14.02.2025.
//
// https://stackoverflow.com/a/77475479
//

import UIKit

protocol ManualTheming: UIView {
    func updateAppearance()
}

extension ManualTheming {
    func registerForApperanceChanges() {
        DispatchQueue.main.async {
            self.registerForTraitChanges(
                [UITraitUserInterfaceStyle.self],
                handler: { (self: Self, _: UITraitCollection) in
                    self.updateAppearance()
                })
        }
    }
}
