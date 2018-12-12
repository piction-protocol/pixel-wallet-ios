//
//  WalletItemModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 06/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxDataSources
import EthereumKit

struct WalletItemModel {
    let name: String
    let address: String
    let network: Network
    let balance: Balance
}

enum WalletItemSection {
    case Section(title: String, items: [WalletItemSectionType])
}

enum WalletItemSectionType {
    case Add
    case Wallet(WalletItemModel)
}

extension WalletItemSection: SectionModelType {
    typealias Item = WalletItemSectionType

    var items: [WalletItemSectionType] {
        switch self {
        case .Section(_, items: let items):
            return items.map { $0 }
        }
    }

    init(original: WalletItemSection, items: [Item]) {
        switch original {
        case .Section(title: let title, _):
            self = .Section(title: title, items: items)
        }
    }
}
