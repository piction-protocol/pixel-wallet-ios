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
        let refreshControlDidRefresh: Driver<Void>
    }

    struct Output {
        let navigationHide: Driver<Void>
        let walletList: Driver<[WalletItemModel]>
        let openWalletItem: Driver<IndexPath>
        let isFetching: Driver<Bool>
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

        let refreshControlDidRefresh = input.refreshControlDidRefresh
            .do(onNext: { [weak self] in
                self?.updater.refreshWallet.onNext(())
            })

        let refreshWalletListAction = refreshControlDidRefresh
            .flatMap { _ -> Driver<Action<[WalletItemModel]>> in
                let list = Driver.just(realm.getWalletList())
                return Action.makeDriver(list)
            }

        return Output(
            navigationHide: navigationHide,
            walletList: walletList,
            openWalletItem: openWalletItem,
            isFetching: refreshWalletListAction.isExecuting
        )
    }
}
