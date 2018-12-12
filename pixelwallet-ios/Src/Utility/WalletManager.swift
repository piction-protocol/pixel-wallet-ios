//
//  WalletManager.swift
//  pixelwallet-ios
//
//  Created by jhseo on 06/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa
import EthereumKit

protocol WalletManagerProtocol {
    func address() -> String
    func privateKey() -> String
    var name: String { get set }
    var network: Network { get set }
}

final class WalletManager: WalletManagerProtocol {
    typealias Dependency = (
        KeychainStorage
    )

    var name: String = "Account 1"
    var network: Network = .piction
    private let wallet: Wallet

    init(dependency: Dependency) {
        let (keychain) = dependency

        wallet = Wallet(network: network.chain, privateKey: keychain[.privateKey] ?? "", debugPrints: false)
    }

    func address() -> String {
        return wallet.address()
    }

    func privateKey() -> String {
        return wallet.privateKey().toHexString()
    }
}
