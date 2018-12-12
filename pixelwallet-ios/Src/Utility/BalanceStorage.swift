//
//  BalanceStorage.swift
//  pixelwallet-ios
//
//  Created by jhseo on 06/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa
import EthereumKit

protocol BalanceStorageProtocol {
    var balance: Observable<Balance> { get }
}

final class BalanceStorage: BalanceStorageProtocol, Injectable {
    var balance: Observable<Balance>

    typealias Dependency = (
        GethManagerProtocol,
        WalletManagerProtocol,
        UpdaterProtocol
    )

    init(dependency: Dependency) {
        let (geth, wallet, updater) = dependency

        let tick = NotificationCenter.default.rx.notification(.willEnterForeground)
            .map { _ in }
            .startWith(())

        balance = Observable.merge(tick, updater.refreshBalance).flatMap { _ -> Observable<Balance> in
            return geth.getTokenBalance(address: wallet.address()).asObservable()
        }
    }
}
