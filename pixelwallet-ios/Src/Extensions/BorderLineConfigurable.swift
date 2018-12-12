//
//  BorderLineConfigurable.swift
//  pixelwallet-ios
//
//  Created by jhseo on 05/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit

protocol BorderLineConfigurable {
    var borderColor: UIColor { get set }
    var borderWidth: CGFloat { get set }
    var cornerRadius: CGFloat { get set }
}
