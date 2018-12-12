//
//  AddWalletCompleteViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 11/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa
import EthereumKit

final class AddWalletCompleteViewModel: InjectableViewModel {
    typealias Dependency = (
        KeychainStorage,
        WalletManagerProtocol
    )

    init(dependency: Dependency) {
        let (keychain, wallet) = dependency

        if keychain[.privateKey] == nil {
            do {
                let seed = try Mnemonic.createSeed(mnemonic: Mnemonic.create())
                let newWallet = try Wallet(seed: seed, network: wallet.network.chain, debugPrints: true)
                keychain[.privateKey] = newWallet.privateKey().toHexString()
            } catch let error {
                print(error)
            }
        }
    }

    struct Input {
        let confirmButtonDidTap: Driver<Void>
    }

    struct Output {
        let dismissViewController: Driver<Void>
    }

    func build(input: Input) -> Output {
        return Output(
            dismissViewController: input.confirmButtonDidTap
        )
    }
}
