//
//  WalletItemCollectionViewCell.swift
//  pixelwallet-ios
//
//  Created by jhseo on 06/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit
import EthereumKit

final class WalletItemCollectionViewCell: ReuseCollectionViewCell {

    @IBOutlet weak var walletNameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var networkNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var networkImageView: UIImageView!

    typealias Model = WalletItemModel

    func configure(with item: Model) {
        let (name, balance, network, address) = (item.name, item.balance, item.network, item.address)

        walletNameLabel.text = name
        balanceLabel.text = try? balance.ether().description
        symbolLabel.text = network.symbol
        networkNameLabel.text = network.description
        addressLabel.text = address
        networkImageView.image = network.image
    }
}


