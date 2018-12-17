//
//  ImportWalletViewController.swift
//  pixelwallet-ios
//
//  Created by jhseo on 10/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ViewModelBindable

final class ImportWalletViewController: UIViewController {
    var disposeBag = DisposeBag()

    @IBOutlet weak var privateKeyTextField: UITextField!
    @IBOutlet weak var importButton: UIButton!

    private func openWalletInfo() {
        let vc = AddWalletCompleteViewController.make()
        if let topViewController = UIApplication.topViewController() {
            topViewController.openViewController(vc, type: .push)
        }
    }
}

extension ImportWalletViewController: ViewModelBindable {
    typealias ViewModel = ImportWalletViewModel

    func bindViewModel(viewModel: ViewModel) {
        let input = ImportWalletViewModel.Input(
            importButtonDidTap: importButton.rx.tap.asDriver(),
            privateKeyTextFieldDidInput: privateKeyTextField.rx.text.orEmpty.asDriver()
        )

        let output = viewModel.build(input: input)

        output
            .openWalletInfo
            .drive(onNext: { [weak self] in
                self?.openWalletInfo()
            })
            .disposed(by: disposeBag)
    }
}
