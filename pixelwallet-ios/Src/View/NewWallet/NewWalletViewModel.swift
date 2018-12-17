//
//  NewWalletViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 14/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa

final class NewWalletViewModel: ViewModel {

    init() {}

    struct Input {
        let newWalletButtonDidTap: Driver<Void>
    }

    struct Output {
        let openAddWallet: Driver<Void>
    }

    func build(input: Input) -> Output {
        let openAddWallet = input.newWalletButtonDidTap

        return Output(
            openAddWallet: openAddWallet
        )
    }
}
