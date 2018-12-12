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
        
        container.register(WalletListViewModel.self) { resolver in
            return WalletListViewModel(dependency: (
                resolver.resolve(KeychainStorage.self)!
            ))
        }

        container.register(WalletItemViewModel.self) { resolver in
            return WalletItemViewModel(dependency: (
                resolver.resolve(WalletManagerProtocol.self)!,
                resolver.resolve(BalanceStorageProtocol.self)!,
                resolver.resolve(KeychainStorage.self)!
            ))
        }

        container.register(AddWalletViewModel.self) { resolver in
            return AddWalletViewModel()
        }
    }
}
