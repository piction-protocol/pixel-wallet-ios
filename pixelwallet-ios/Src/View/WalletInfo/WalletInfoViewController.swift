//
//  WalletInfoViewController.swift
//  pixelwallet-ios
//
//  Created by jhseo on 10/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ViewModelBindable

final class WalletInfoViewController: UIViewController {
    var disposeBag = DisposeBag()

    @IBOutlet weak var networkLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var privateKeyLabel: UILabel!
    @IBOutlet weak var copyClipboardButton: UIButtonExtension!
}

extension WalletInfoViewController: ViewModelBindable {
    typealias ViewModel = WalletInfoViewModel

    func bindViewModel(viewModel: ViewModel) {
        let input = WalletInfoViewModel.Input(
            viewWillAppear: rx.viewWillAppear.asDriver()
        )

        let output = viewModel.build(input: input)

        output
            .walletInfoItem
            .drive(onNext: { [weak self] info in
                self?.accountLabel.text = info.address
                self?.privateKeyLabel.text = info.privateKey
                self?.networkLabel.text = info.network.description
            })
            .disposed(by: disposeBag)
    }
}
