//
//  AddWalletCompleteViewController.swift
//  pixelwallet-ios
//
//  Created by jhseo on 11/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ViewModelBindable

class AddWalletCompleteViewController: UIViewController {
    var disposeBag = DisposeBag()

    @IBOutlet weak var walletInfoContainerView: UIView!
    @IBOutlet weak var confirmButton: UIButtonExtension!

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc = WalletInfoViewController.make()
        embed(vc, to: walletInfoContainerView)

        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}

extension AddWalletCompleteViewController: ViewModelBindable {
    typealias ViewModel = AddWalletCompleteViewModel

    func bindViewModel(viewModel: ViewModel) {
        let input = AddWalletCompleteViewModel.Input(
            confirmButtonDidTap: confirmButton.rx.tap.asDriver()
        )

        let output = viewModel.build(input: input)

        output
            .dismissViewController
            .drive(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
