//
//  WalletHistoryViewController.swift
//  pixelwallet-ios
//
//  Created by jhseo on 06/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ViewModelBindable

final class WalletHistoryViewController: UITableViewController {
    var disposeBag = DisposeBag()

    @IBOutlet weak var containerView: UIView!

    private func embedWalletItemViewController(index: Int) {
        let vc = WalletItemViewController.make(index: index)
        embed(vc, to: containerView)
    }
}

extension WalletHistoryViewController: ViewModelBindable {
    typealias ViewModel = WalletHistoryViewModel

    func bindViewModel(viewModel: ViewModel) {

        let input = WalletHistoryViewModel.Input(
            viewWillAppear: rx.viewWillAppear.asDriver(),
            refreshControlDidRefresh: refreshControl!.rx.controlEvent(.valueChanged).asDriver()
        )

        let output = viewModel.build(input: input)

        output
            .navigationShow
            .drive(onNext: { [weak self] _ in
                self?.navigationController?.setNavigationBarHidden(false, animated: false)
                self?.navigationController?.setNavigationBarLine(true)
            })
            .disposed(by: disposeBag)

        output
            .embedWalletItemViewcontroller
            .drive(onNext: { [weak self] index in
                self?.embedWalletItemViewController(index: index)
            })
            .disposed(by: disposeBag)

        output
            .isFetching
            .drive(refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
    }
}
