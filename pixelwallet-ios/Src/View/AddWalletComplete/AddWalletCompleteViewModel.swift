//
//  AddWalletCompleteViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 11/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyJSON
import EthereumKit

final class AddWalletCompleteViewModel: InjectableViewModel {
    typealias Dependency = (
        KeychainStorage,
        WalletManagerProtocol,
        UpdaterProtocol,
        RealmManager
    )

    let keychain: KeychainStorage
    let wallet: WalletManagerProtocol
    let updater: UpdaterProtocol
    let realmManager: RealmManager

    init(dependency: Dependency) {
        (keychain, wallet, updater, realmManager) = dependency
//        let (keychain, wallet, updater, realm) = dependency

//        let keychainData = keychain[.privateKey]
//        var json = JSON(keychainData)
//
//        if let newWallet = json["accounts"].array?.last {
//
//            let address = newWallet["address"].stringValue
//
//            let accountCount = realm.getWalletCount()
//            realm.insertWalletItem(name: "My Account \(accountCount + 1)", address: address, network: wallet.network)
//        }

//        updater.refreshWallet.onNext(())
//        updater.refreshBalance.onNext(())
    }

    struct Input {
        let viewWillAppear: Driver<Void>
        let confirmButtonDidTap: Driver<Void>
    }

    struct Output {
        let dismissViewController: Driver<Void>
        let embedWalletInfo: Driver<Int>
    }

    func build(input: Input) -> Output {
        let realm = realmManager
        let embedWalletInfo = input.viewWillAppear
            .flatMapLatest { _ -> Driver<Int> in
                let lastIndex = realm.getWalletCount() - 1
                return Driver.just(lastIndex)
            }

        return Output(
            dismissViewController: input.confirmButtonDidTap,
            embedWalletInfo: embedWalletInfo
        )
    }
}
