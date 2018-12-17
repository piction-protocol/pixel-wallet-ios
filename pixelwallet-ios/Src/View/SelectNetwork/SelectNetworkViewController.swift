//
//  SelectNetworkViewController.swift
//  pixelwallet-ios
//
//  Created by jhseo on 10/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ViewModelBindable

final class SelectNetworkViewController: UITableViewController {
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
    }
}

extension SelectNetworkViewController: ViewModelBindable {
    typealias ViewModel = SelectNetworkViewModel

    func bindViewModel(viewModel: ViewModel) {
        let input = SelectNetworkViewModel.Input(
            itemSelected: tableView.rx.itemSelected.asDriver()
        )

        let output = viewModel.build(input: input)

        Driver
            .combineLatest(output.selectedIndexPath, output.addWalletType)
            .drive(onNext: { indexPath, type in
                if let topViewController = UIApplication.topViewController() {
                    let vc = type == .create ? AddWalletCompleteViewController.make() : ImportWalletViewController.make()
                    topViewController.openViewController(vc, type: .push)
                }
            })
            .disposed(by: disposeBag)
    }
}
