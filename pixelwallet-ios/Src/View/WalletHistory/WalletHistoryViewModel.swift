//
//  WalletHistoryViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 06/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa
import EthereumKit

final class WalletHistoryViewModel: InjectableViewModel {
    typealias Dependency = (
        WalletManagerProtocol,
        BalanceStorageProtocol,
        KeychainStorage,
        Int
    )

    private var wallet: WalletManagerProtocol
    private let balanceStorage: BalanceStorageProtocol
    private let keychain: KeychainStorage
    private let walletIndex: Int

    init(dependency: Dependency) {
        (wallet, balanceStorage, keychain, walletIndex) = dependency
    }

    struct Input {
        let viewWillAppear: Driver<Void>
    }

    struct Output {
        let navigationShow: Driver<Void>
        let embedWalletItemViewcontroller: Driver<Int>
//        let walletItems: Driver<[WalletItemSection]>
    }

    func build(input: Input) -> Output {
        let navigationShow = input.viewWillAppear
        let index = walletIndex

        let embedWalletItemViewcontroller = input.viewWillAppear
            .flatMapLatest { _ -> Driver<Int> in
                return Driver.just(index)
            }
//        let address = Action.makeDriver(wallet.address()).elements
//        let balance = Action.makeDriver(balanceStorage.balance).elements
//
//        let isExistPrivateKey = Driver.just(self.keychain[.privateKey] == nil)

//        let walletAction = Driver.combineLatest(address, balance)
//            .flatMap { [weak self] address, balance -> Driver<Action<WalletItemSection>> in
//                let name = self?.wallet.name
//                let network = self?.wallet.network
//
//                let walletItem = Driver.just(WalletItemSection.Section(title: "", items: [.Wallet(WalletItemModel(name: name!, address: address, network: network!, balance: balance))]))
//                return Action.makeDriver(walletItem)
//            }
//
//        let walletItems = Driver.combineLatest(input.viewWillAppear, isExistPrivateKey)
//            .flatMap { _, _ -> Driver<[WalletItemSection]> in
//                let section: [WalletItemSection] = [WalletItemSection.Section(title: "", items: [.Add])]
//                return Driver.just(section)
//            }

//        let walletItems = isExistPrivateKey
//            .withLatestFrom(walletAction.elements)
//            .flatMapLatest { isExist, walletItem -> Driver<[WalletItemSection]> in
//
//                var section: [WalletItemSection] = []
//                if isExist {
//                    section.append(walletItem)
//                }
//                section.append(WalletItemSection.Section(title: "", items: [.Add]))
//                return Driver.just(section)
//            }

        return Output(
            navigationShow: navigationShow,
            embedWalletItemViewcontroller: embedWalletItemViewcontroller
//            walletItems: walletItems
        )
    }
}
