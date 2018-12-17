//
//  UINavigationController+Extension.swift
//  pixelwallet-ios
//
//  Created by jhseo on 17/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit

extension UINavigationController {
    public func setNavigationBarLine(_ show: Bool) {
        if show {
            navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:UIBarMetrics.default)
            navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
        } else {
            navigationBar.setBackgroundImage(UIImage().imageWithColor(color: .white), for:UIBarMetrics.default)
            navigationBar.shadowImage = UIImage()
        }
    }
}
