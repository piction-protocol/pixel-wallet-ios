//
//  AddWalletViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 10/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa

final class AddWalletViewModel: ViewModel {
    init() {}

    struct Input {
        let itemSelected: Driver<IndexPath>
        let closeButtonDidTap: Driver<Void>
    }

    struct Output {
        let selectedIndexPath: Driver<IndexPath>
        let dismissViewController: Driver<Void>
    }

    func build(input: Input) -> Output {
        return Output(
            selectedIndexPath: input.itemSelected,
            dismissViewController: input.closeButtonDidTap
        )
    }
}
