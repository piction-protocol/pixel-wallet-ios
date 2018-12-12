//
//  UIViewController.Container+Extension.swift
//  pixelwallet-ios
//
//  Created by jhseo on 05/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import Swinject
import UIKit

extension WalletListViewController {
    static func make() -> WalletListViewController {
        return Container.shared.resolve(WalletListViewController.self)!
    }
}

extension WalletItemViewController {
    static func make() -> WalletItemViewController {
        return Container.shared.resolve(WalletItemViewController.self)!
    }
}
