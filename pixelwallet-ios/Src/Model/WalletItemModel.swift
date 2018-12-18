//
//  WalletItemModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 06/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import EthereumKit

struct WalletItemModel {
    let name: String
    let address: String
    let network: Network
    let balance: Balance
}
