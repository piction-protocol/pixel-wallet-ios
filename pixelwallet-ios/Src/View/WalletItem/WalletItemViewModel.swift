//
//  WalletItemViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 17/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa
import EthereumKit

final class WalletItemViewModel: InjectableViewModel {
    typealias Dependency = (
        BalanceStorageProtocol,
        RealmManager,
        Int
    )

    private let balanceStorage: BalanceStorageProtocol
    private let realmManager: RealmManager
    private let walletIndex: Int

    init(dependency: Dependency) {
        (balanceStorage, realmManager, walletIndex) = dependency
    }

    struct Input {
        let viewWillAppear: Driver<Void>
    }

    struct Output {
        let walletItems: Driver<WalletItemModel>
    }

    func build(input: Input) -> Output {
        let realm = realmManager
        let index = walletIndex

        let walletItems = input.viewWillAppear
            .flatMapLatest { _ -> Driver<WalletItemModel> in
                let item = realm.getWalletItem(index: index)
                return Driver.just(item)
        }

        return Output(
            walletItems: walletItems
        )
    }
}

