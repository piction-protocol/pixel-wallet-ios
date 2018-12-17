//
//  WalletListCollectionViewCell.swift
//  pixelwallet-ios
//
//  Created by jhseo on 06/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit
import EthereumKit

final class WalletListCollectionViewCell: ReuseCollectionViewCell {
    @IBOutlet weak var networkNameLabel: UILabel!
    @IBOutlet weak var walletNameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!

    typealias Model = WalletItemModel

    func configure(with model: Model) {
        let (name, balance, network, address) = (model.name, model.balance, model.network, model.address)

        walletNameLabel.text = name
        balanceLabel.text = try? balance.ether().description
        symbolLabel.text = network.symbol
        networkNameLabel.text = network.description
    }
}


