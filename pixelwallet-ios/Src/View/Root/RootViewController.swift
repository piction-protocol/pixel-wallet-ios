//
//  RootViewController.swift
//  pixelwallet-ios
//
//  Created by jhseo on 14/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ViewModelBindable

final class RootViewController: UIViewController {
    var disposeBag = DisposeBag()

    private func showTabBarController() {
        let viewController = TabBarController()
        embed(viewController, to: view)
    }
}

extension RootViewController: ViewModelBindable {

    typealias ViewModel = RootViewModel

    func bindViewModel(viewModel: ViewModel) {

        let input = RootViewModel.Input(
            viewWillAppear: rx.viewWillAppear.asDriver()
        )

        let output = viewModel.build(input: input)

        output
            .showTabBarController
            .drive(onNext: { [weak self] in
                self?.showTabBarController()
            })
            .disposed(by: disposeBag)
    }
}
