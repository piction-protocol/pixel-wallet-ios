//
//  ViewModelAssembly.swift
//  pixelwallet-ios
//
//  Created by jhseo on 05/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import Swinject

final class ViewModelAssembly: Assembly {
    func assemble(container: Container) {

        container.register(RootViewModel.self) { resolver in
            return RootViewModel(dependency: (
                resolver.resolve(KeychainStorage.self)!
            ))
        }
        
        container.register(WalletListViewModel.self) { resolver in
            return WalletListViewModel(dependency: (
                resolver.resolve(RealmManager.self)!,
                resolver.resolve(UpdaterProtocol.self)!
            ))
        }

        container.register(NewWalletViewModel.self) { resolver in
            return NewWalletViewModel()
        }

        container.register(WalletHistoryViewModel.self) { (resolver, index: Int) in
            return WalletHistoryViewModel(dependency: (
                resolver.resolve(WalletManagerProtocol.self)!,
                resolver.resolve(BalanceStorageProtocol.self)!,
                resolver.resolve(KeychainStorage.self)!,
                resolver.resolve(UpdaterProtocol.self)!,
                index
            ))
        }

        container.register(WalletItemViewModel.self) { (resolver, index: Int) in
            return WalletItemViewModel(dependency: (
                resolver.resolve(BalanceStorageProtocol.self)!,
                resolver.resolve(RealmManager.self)!,
                index
            ))
        }

        container.register(AddWalletViewModel.self) { resolver in
            return AddWalletViewModel()
        }

        container.register(SelectNetworkViewModel.self) { (resolver, type: AddWalletType) in
            return SelectNetworkViewModel(dependency: (
                resolver.resolve(KeychainStorage.self)!,
                resolver.resolve(RealmManager.self)!,
                resolver.resolve(UpdaterProtocol.self)!,
                type
            ))
        }

        container.register(ImportWalletViewModel.self) { resolver in
            return ImportWalletViewModel(dependency: (
                resolver.resolve(KeychainStorage.self)!,
                resolver.resolve(RealmManager.self)!,
                resolver.resolve(UpdaterProtocol.self)!
            ))
        }

        container.register(WalletInfoViewModel.self) { (resolver, index: Int) in
            return WalletInfoViewModel(dependency: (
                resolver.resolve(KeychainStorage.self)!,
                resolver.resolve(RealmManager.self)!,
                index
            ))
        }

        container.register(AddWalletCompleteViewModel.self) { resolver in
            return AddWalletCompleteViewModel(dependency: (
                resolver.resolve(KeychainStorage.self)!,
                resolver.resolve(WalletManagerProtocol.self)!,
                resolver.resolve(UpdaterProtocol.self)!,
                resolver.resolve(RealmManager.self)!
            ))
        }

        container.register(SettingViewModel.self) { resolver in
            return SettingViewModel(dependency: (
                resolver.resolve(RealmManager.self)!,
                resolver.resolve(KeychainStorage.self)!,
                resolver.resolve(UpdaterProtocol.self)!
            ))
        }
    }
}
