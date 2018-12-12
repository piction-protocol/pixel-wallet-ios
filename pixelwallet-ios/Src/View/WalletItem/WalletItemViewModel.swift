//
//  WalletItemViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 06/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa
import EthereumKit

final class WalletItemViewModel: InjectableViewModel {
    typealias Dependency = (
        WalletManagerProtocol,
        BalanceStorageProtocol,
        KeychainStorage
    )

    private var wallet: WalletManagerProtocol
    private let balanceStorage: BalanceStorageProtocol
    private let keychain: KeychainStorage

    init(dependency: Dependency) {
        (wallet, balanceStorage, keychain) = dependency
    }

    struct Input {
        let viewWillAppear: Driver<Void>
    }

    struct Output {
        let walletItems: Driver<[WalletItemSection]>
    }

    func build(input: Input) -> Output {
        let name = Driver.just(wallet.name)
        let address = Driver.just(wallet.address())
        let balance = Action.makeDriver(balanceStorage.balance).elements
        let network = Driver.just(wallet.network)

        let walletItems = Driver.combineLatest(name, address, network, balance) {
            return [
                WalletItemSection.Section(title: "", items: [.Wallet(WalletItemModel(name: $0, address: $1, network: $2, balance: $3))]),
                WalletItemSection.Section(title: "", items: [.Add])
                ]
        }

        return Output(
            walletItems: walletItems
        )
    }
}
