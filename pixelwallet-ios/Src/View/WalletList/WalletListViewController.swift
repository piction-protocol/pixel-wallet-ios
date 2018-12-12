//
//  WalletListViewController.swift
//  pixelwallet-ios
//
//  Created by jhseo on 03/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ViewModelBindable

class WalletListViewController: UITableViewController {
    var disposeBag = DisposeBag()

    @IBOutlet weak var walletItemContainerView: UIView!

    private func openAddWallet() {
        let vc = AddWalletViewController.make()
        if let topViewController = UIApplication.topViewController() {
            topViewController.openViewController(vc, type: .present)
        }
    }
}

extension WalletListViewController: ViewModelBindable {
    typealias ViewModel = WalletListViewModel

    func bindViewModel(viewModel: ViewModel) {
        let vc = WalletItemViewController.make()
        embed(vc, to: walletItemContainerView)

        let input = WalletListViewModel.Input(
            viewDidAppear: rx.viewDidAppear.asDriver()
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
