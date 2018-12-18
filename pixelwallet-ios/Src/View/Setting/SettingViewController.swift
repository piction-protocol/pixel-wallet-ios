//
//  SettingViewController.swift
//  pixelwallet-ios
//
//  Created by jhseo on 14/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ViewModelBindable

enum SettingSection: Int {
    case wallet
    case security
    case debug
}

final class SettingViewController: UITableViewController {
    var disposeBag = DisposeBag()
}

extension SettingViewController: ViewModelBindable {
    typealias ViewModel = SettingViewModel

    func bindViewModel(viewModel: ViewModel) {

        let input = SettingViewModel.Input(
            itemSelected: tableView.rx.itemSelected.asDriver()
        )

        let output = viewModel.build(input: input)

        output
            .selectedIndexPath
            .drive(onNext: { indexPath in
                switch SettingSection(rawValue: indexPath.section)! {
                case .wallet:
                    print("wallet")
                case .security:
                    print("security")
                default:
                    print("error")
                }
            })
            .disposed(by: disposeBag)

        output
            .selectedDebug
            .drive(onNext: { _ in
                print("deleted")
            })
            .disposed(by: disposeBag)
    }
}
