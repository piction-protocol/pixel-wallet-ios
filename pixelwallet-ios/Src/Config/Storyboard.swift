//
//  Storyboard.swift
//  pixelwallet-ios
//
//  Created by jhseo on 03/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit

public enum Storyboard: String {
    case MainTabBar
    case Setting

    /* Wallet */
    case WalletList
    case NewWallet
    case WalletItem
    case AddWallet
    case SelectNetwork
    case CreateWallet
    case ImportWallet
    case WalletInfo
    case AddWalletComplete

    public func instantiate<VC: UIViewController>(_ viewController: VC.Type) -> VC {
        guard
            let vc = UIStoryboard(name: self.rawValue, bundle: nil)
                .instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC
            else { fatalError("Couldn't instantiate \(VC.storyboardIdentifier) from \(self.rawValue)") }

        return vc
    }
}
