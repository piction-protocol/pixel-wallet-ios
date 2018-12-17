//
//  UIImage+Extension.swift
//  pixelwallet-ios
//
//  Created by jhseo on 17/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit

extension UIImage {
    func imageWithColor(color: UIColor, size: CGSize=CGSize(width: 1, height: 1)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
