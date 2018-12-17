//
//  NewWalletViewController.swift
//  pixelwallet-ios
//
//  Created by jhseo on 14/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ViewModelBindable

final class NewWalletViewController: UIViewController {
    var disposeBag = DisposeBag()

    @IBOutlet weak var newWalletButton: UIButton!

    private func openAddWallet() {
        let vc = AddWalletViewController.make()
        if let topViewController = UIApplication.topViewController() {
            topViewController.openViewController(vc, type: .present)
        }
    }
}

extension NewWalletViewController: ViewModelBindable {
    typealias ViewModel = NewWalletViewModel

    func bindViewModel(viewModel: ViewModel) {

        let input = NewWalletViewModel.Input(
            newWalletButtonDidTap: newWalletButton.rx.tap.asDriver()
        )

        let output = viewModel.build(input: input)

        output
            .openAddWallet
            .drive(onNext: { [weak self] in
                self?.openAddWallet()
            })
            .disposed(by: disposeBag)
    }
}
