//
//  WalletItemViewController.swift
//  pixelwallet-ios
//
//  Created by jhseo on 17/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ViewModelBindable

final class WalletItemViewController: UIViewController {
    var disposeBag = DisposeBag()

    @IBOutlet weak var addressButton: UIButtonExtension!
}

extension WalletItemViewController: ViewModelBindable {
    typealias ViewModel = WalletItemViewModel

    func bindViewModel(viewModel: ViewModel) {

        let input = WalletItemViewModel.Input(
            viewWillAppear: rx.viewWillAppear.asDriver()
        )

        let output = viewModel.build(input: input)

        output
            .walletItems
            .drive(onNext: { [weak self] item in
                self?.addressButton.setTitle(item.address, for: .normal)
            })
            .disposed(by: disposeBag)
    }
}
