//
//  RootViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 14/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa

final class RootViewModel: InjectableViewModel {
    typealias Dependency = (
        KeychainStorage
    )

    private let keychain: KeychainStorage

    init(dependency: Dependency) {
        (keychain) = dependency
    }

    struct Input {
        let viewWillAppear: Driver<Void>
    }

    struct Output {
        let showTabBarController: Driver<Void>
    }

    func build(input: Input) -> Output {
        let showTabBarController = input.viewWillAppear

        return Output(
            showTabBarController: showTabBarController
        )
    }
}
