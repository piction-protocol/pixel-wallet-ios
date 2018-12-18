//
//  SettingViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 14/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa

final class SettingViewModel: InjectableViewModel {
    typealias Dependency = (
        RealmManager,
        KeychainStorage,
        UpdaterProtocol
    )

    private let realmManager: RealmManager
    private let keychain: KeychainStorage
    private let updater: UpdaterProtocol

    init(dependency: Dependency) {
        (realmManager, keychain, updater) = dependency
    }

    struct Input {
        let itemSelected: Driver<IndexPath>
    }

    struct Output {
        let selectedIndexPath: Driver<IndexPath>
        let selectedDebug: Driver<Void>
    }

    func build(input: Input) -> Output {
        let realm = realmManager
        let selectedDebug = input.itemSelected
            .flatMapLatest { [weak self] indexPath -> Driver<Void> in
                switch SettingSection(rawValue: indexPath.section)! {
                case .wallet,
                     .security:
                    return Driver.empty()
                case .debug:
                    realm.removeAllWalletItems()
                    self?.keychain.clearKeychain()
                    self?.updater.refreshWallet.onNext(())
                    return Driver.just(())
                }
            }

        let selectedIndexPath = input.itemSelected
            .flatMapLatest { indexPath -> Driver<IndexPath> in
                switch SettingSection(rawValue: indexPath.section)! {
                case .wallet,
                     .security:
                    return Driver.just(indexPath)
                case .debug:
                    return Driver.empty()
                }
        }

        return Output(
            selectedIndexPath: selectedIndexPath,
            selectedDebug: selectedDebug
        )
    }
}
