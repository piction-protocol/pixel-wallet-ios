//
//  UtilityAssembly.swift
//  pixelwallet-ios
//
//  Created by jhseo on 05/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import Swinject

final class UtilityAssembly: Assembly {
    func assemble(container: Container) {

        container.register(BalanceStorageProtocol.self) { resolver in
            return BalanceStorage(dependency: (
                resolver.resolve(GethManagerProtocol.self)!,
                resolver.resolve(WalletManagerProtocol.self)!,
                resolver.resolve(UpdaterProtocol.self)!
            ))
        }
        .inObjectScope(.container)

        container.register(WalletManagerProtocol.self) { resolver in
            return WalletManager(dependency: (
                resolver.resolve(KeychainStorage.self)!
            ))
        }
        .inObjectScope(.container)

        container.register(GethManagerProtocol.self) { resolver in
            return GethManager(dependency: (
                resolver.resolve(WalletManagerProtocol.self)!
            ))
        }

        container.register(UpdaterProtocol.self) { resolver in
            return Updater()
        }
        .inObjectScope(.container)

        container.register(KeychainStorage.self) { resolver in
            return KeychainStorage()
        }

        container.register(RealmManager.self) { resolver in
            return RealmManager()
        }
    }
}
