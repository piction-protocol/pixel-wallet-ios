//
//  WalletInfoViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 10/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa

final class WalletInfoViewModel: InjectableViewModel {
    typealias Dependency = (
        KeychainStorage,
        WalletManagerProtocol
    )

    let keychain: KeychainStorage
    let wallet: WalletManagerProtocol

    init(dependency: Dependency) {
        (keychain, wallet) = dependency
    }

    struct Input {
        let viewWillAppear: Driver<Void>
    }

    struct Output {
        let address: Driver<String>
        let privateKey: Driver<String?>
        let network: Driver<Network>
    }

    func build(input: Input) -> Output {
        let address = self.wallet.address()
        let privateKey = self.keychain[.privateKey]
        let network = self.wallet.network

        return Output(
            address: Driver.just(address),
            privateKey: Driver.just(privateKey),
            network: Driver.just(network)
        )
    }
}
