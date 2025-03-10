//
//  UICollectionViewFlowLayout+Ext.swift
//  WhoFollows
//
//  Created by Maks Winters on 07.02.2025.
//

import UIKit

extension UICollectionViewFlowLayout {
    private func allAroundSectionInset(padding: CGFloat) {
        return self.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
    }
    func setupCustomFlowLayout(
        numOfColumns: CGFloat,
        itemSpacing: CGFloat = 10,
        padding: CGFloat = 12,
        addToHeight: CGFloat = 0,
        view: UIView
    ) -> UICollectionViewFlowLayout {
        
        guard numOfColumns > 1 else {
            fatalError("Minimum number of columns should be at least 2!")
        }
        let width = view.bounds.width
        let minimumItemSpacingCalculated = itemSpacing * (numOfColumns - 1)
        let availableWidth = width - (padding * 2) - minimumItemSpacingCalculated
        // Item setup
        let itemWidth = availableWidth / numOfColumns
        self.allAroundSectionInset(padding: padding)
        self.itemSize = CGSize(width: itemWidth, height: itemWidth + addToHeight)
        // Return
        return self
        
    }
}
