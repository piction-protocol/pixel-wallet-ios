//
//  SelectNetworkViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 10/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa

final class SelectNetworkViewModel: InjectableViewModel {
    typealias Dependency = (
        WalletManagerProtocol,
        AddWalletType
    )

    private var wallet: WalletManagerProtocol
    let addWalletType: AddWalletType

    init(dependency: Dependency) {
        (wallet, addWalletType) = dependency
    }

    struct Input {
        let itemSelected: Driver<IndexPath>
    }

    struct Output {
        let addWalletType: Driver<AddWalletType>
        let selectedIndexPath: Driver<IndexPath>
    }

    func build(input: Input) -> Output {
        let addWalletType = self.addWalletType
        let selectedIndexPath = input.itemSelected
            .flatMapLatest { [weak self] indexPath -> Driver<IndexPath> in
                self?.wallet.network = Network(rawValue: indexPath.row)!
                self?.wallet.name = "kk"
                return Driver.just(indexPath)
            }

        return Output(
            addWalletType: Driver.just(addWalletType),
            selectedIndexPath: selectedIndexPath
        )
    }
}
