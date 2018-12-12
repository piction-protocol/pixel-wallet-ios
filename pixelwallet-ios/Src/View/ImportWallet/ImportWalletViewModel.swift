//
//  ImportWalletViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 10/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa

final class ImportWalletViewModel: InjectableViewModel {
    typealias Dependency = (
        KeychainStorage
    )

    let keychain: KeychainStorage

    init(dependency: Dependency) {
        (keychain) = dependency
    }

    struct Input {
        let importButtonDidTap: Driver<Void>
        let privateKeyTextFieldDidInput: Driver<String>
    }

    struct Output {
        let openWalletInfo: Driver<Void>
    }

    func build(input: Input) -> Output {
        let openWalletInfo = input.importButtonDidTap
            .withLatestFrom(input.privateKeyTextFieldDidInput)
            .flatMapLatest { [weak self] privateKey -> Driver<Void> in
                guard privateKey.validateHex() else {
                    return Driver.empty()
                }

                self?.keychain[.privateKey] = privateKey
                return input.importButtonDidTap
            }

        return Output(
            openWalletInfo: openWalletInfo
        )
    }
}

