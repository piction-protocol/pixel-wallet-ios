//
//  Updater.swift
//  pixelwallet-ios
//
//  Created by jhseo on 07/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa

protocol UpdaterProtocol {
    var refreshBalance: PublishSubject<Void> { get }
}

final class Updater: UpdaterProtocol {
    let refreshBalance = PublishSubject<Void>()

    private let disposeBag = DisposeBag()

    init() {
        let blockInterval = 15.0
        let ticker = Driver<Int>
            .interval(blockInterval)
            .map { _ in }

        ticker
            .drive(refreshBalance)
            .disposed(by: disposeBag)
    }
}
