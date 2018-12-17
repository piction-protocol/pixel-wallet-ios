//
//  UICollectionView+Extension.swift
//  pixelwallet-ios
//
//  Created by jhseo on 12/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit

enum CollectionViewReusableType: String {
    case header
    case footer

    var typeName: String {
        switch self {
        case .header:
            return UICollectionElementKindSectionHeader
        case .footer:
            return UICollectionElementKindSectionFooter
        }
    }
}

class ReuseCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

class ReuseCollectionReusableView: UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func registerXib<T>(_: T.Type) where T: ReuseCollectionViewCell {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func registerReusableView<T>(_: T.Type, kind: CollectionViewReusableType) where T: ReuseCollectionReusableView {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind.typeName, withReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T>(forIndexPath indexPath: IndexPath) -> T where T: ReuseCollectionViewCell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func dequeueReusableView<T>(_: T.Type, indexPath: IndexPath, kind: CollectionViewReusableType) -> T where T: ReuseCollectionReusableView {
        guard let reusableView = dequeueReusableSupplementaryView(ofKind: kind.typeName, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue reusableView with identifier: \(T.reuseIdentifier)")
        }
        return reusableView
    }

    func scrollToSection(_ section: Int)  {
        guard section < numberOfSections else { return }
        guard let attribute = layoutAttributesForItem(at: IndexPath(row: 0, section: section)) else { return }
        guard let flowLayout = self.collectionViewLayout as? LeftAlignedCollectionViewFlowLayout else { return }

        let headerSize = flowLayout.headerReferenceSize.height
        let topOfHeader = CGPoint(x: 0, y: max(0, attribute.frame.origin.y - contentInset.top - headerSize))
        setContentOffset(topOfHeader, animated: true)
    }
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left

        attributes?.forEach { layoutAttribute in
            if layoutAttribute.representedElementCategory == .cell {
                if layoutAttribute.frame.origin.x == sectionInset.left {
                    leftMargin = sectionInset.left
                } else {
                    layoutAttribute.frame.origin.x = leftMargin
                }
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            }
        }
        return attributes
    }
}
