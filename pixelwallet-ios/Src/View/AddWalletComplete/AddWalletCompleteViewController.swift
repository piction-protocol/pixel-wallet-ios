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

final class AddWalletCompleteViewController: UIViewController {
    var disposeBag = DisposeBag()

    @IBOutlet weak var walletInfoContainerView: UIView!
    @IBOutlet weak var confirmButton: UIButtonExtension!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    private func embedWalletInfoController(index: Int) {
        let vc = WalletInfoViewController.make(index: index)
        embed(vc, to: walletInfoContainerView)
    }
}

extension AddWalletCompleteViewController: ViewModelBindable {
    typealias ViewModel = AddWalletCompleteViewModel

    func bindViewModel(viewModel: ViewModel) {
        let input = AddWalletCompleteViewModel.Input(
            viewWillAppear: rx.viewWillAppear.asDriver(),
            confirmButtonDidTap: confirmButton.rx.tap.asDriver()
        )

        let output = viewModel.build(input: input)

        output
            .embedWalletInfo
            .drive(onNext: { [weak self] index in
                self?.embedWalletInfoController(index: index)
            })
            .disposed(by: disposeBag)

        output
            .dismissViewController
            .drive(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
