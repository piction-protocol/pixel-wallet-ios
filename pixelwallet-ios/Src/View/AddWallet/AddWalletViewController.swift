//
//  AddWalletViewController.swift
//  pixelwallet-ios
//
//  Created by jhseo on 10/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ViewModelBindable

enum AddWalletType: Int {
    case create
    case `import`
}

class AddWalletViewController: UITableViewController {
    var disposeBag = DisposeBag()

    @IBOutlet weak var closeButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
    }
}

extension AddWalletViewController: ViewModelBindable {
    typealias ViewModel = AddWalletViewModel

    func bindViewModel(viewModel: ViewModel) {
        let input = AddWalletViewModel.Input(
            itemSelected: tableView.rx.itemSelected.asDriver(),
            closeButtonDidTap: closeButton.rx.tap.asDriver()
        )

        let output = viewModel.build(input: input)

        output
            .selectedIndexPath
            .drive(onNext: { indexPath in
                if let topViewController = UIApplication.topViewController() {
                    let walletType = AddWalletType(rawValue: indexPath.row)!
                    let vc = SelectNetworkViewController.make(type: walletType)
                    topViewController.openViewController(vc, type: .push)
                }
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
