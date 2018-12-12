//
//  WalletItemEmptyCollectionViewCell.swift
//  pixelwallet-ios
//
//  Created by jhseo on 07/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit

final class WalletItemEmptyCollectionViewCell: ReuseCollectionViewCell {

    @IBAction func openAddWallet(_ sender: Any) {
        if let topViewController = UIApplication.topViewController() {
            let vc = AddWalletViewController.make()
            topViewController.openViewController(vc, type: .present)
        }
    }
}
