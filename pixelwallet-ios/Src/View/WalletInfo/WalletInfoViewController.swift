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

class WalletInfoViewController: UIViewController {
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
            .address
            .drive(onNext: { [weak self] address in
                self?.accountLabel.text = address
            })
            .disposed(by: disposeBag)

        output
            .privateKey
            .drive(onNext: { [weak self] privateKey in
                self?.privateKeyLabel.text = privateKey
            })
            .disposed(by: disposeBag)

        output
            .network
            .drive(onNext: { [weak self] network in
                self?.networkLabel.text = network.description
            })
            .disposed(by: disposeBag)
    }
}
