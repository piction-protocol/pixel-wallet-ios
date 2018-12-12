//
//  WalletListViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 04/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa

final class WalletListViewModel: InjectableViewModel {
    typealias Dependency = (
        KeychainStorage
    )

    private let keychain: KeychainStorage

    init(dependency: Dependency) {
        (keychain) = dependency
    }

    struct Input {
        let viewDidAppear: Driver<Void>
    }

    struct Output {
        let openAddWallet: Driver<Void>
    }

    func build(input: Input) -> Output {
        self.keychain.clearKeychain()
        let openAddWallet = input.viewDidAppear
            .filter { [weak self] _ in
                return self?.keychain[.privateKey] == nil
            }

        return Output(
            openAddWallet: openAddWallet
        )
    }
}
