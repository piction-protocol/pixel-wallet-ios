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

final class SettingViewController: UITableViewController {
    var disposeBag = DisposeBag()
}

extension SettingViewController: ViewModelBindable {
    typealias ViewModel = SettingViewModel

    func bindViewModel(viewModel: ViewModel) {

        let input = SettingViewModel.Input(
        )

        let output = viewModel.build(input: input)
    }
}

