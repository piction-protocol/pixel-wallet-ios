//
//  WalletListViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 04/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa
import EthereumKit

final class WalletListViewModel: InjectableViewModel {
    typealias Dependency = (
        RealmManager,
        UpdaterProtocol
    )

    private let realmManager: RealmManager
    private let updater: UpdaterProtocol

    init(dependency: Dependency) {
        (realmManager, updater) = dependency
    }

    struct Input {
        let viewWillAppear: Driver<Void>
        let selectedIndexPath: Driver<IndexPath>
    }

    struct Output {
        let navigationHide: Driver<Void>
        let walletList: Driver<[WalletItemModel]>
        let openWalletItem: Driver<IndexPath>
    }

    func build(input: Input) -> Output {
        let realm = realmManager
        let walletList = Driver.merge(input.viewWillAppear, updater.refreshWallet.asDriver(onErrorDriveWith: .empty()))
            .flatMap { _ -> Driver<[WalletItemModel]> in
                let list = realm.getWalletList()
                return Driver.just(list)
        }

        let navigationHide = input.viewWillAppear

        let openWalletItem = input.selectedIndexPath

        return Output(
            navigationHide: navigationHide,
            walletList: walletList,
            openWalletItem: openWalletItem
        )
    }
}
