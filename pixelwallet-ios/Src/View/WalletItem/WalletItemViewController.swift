//
//  WalletItemViewController.swift
//  pixelwallet-ios
//
//  Created by jhseo on 06/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ViewModelBindable

class WalletItemViewController: UIViewController {
    var disposeBag = DisposeBag()

    @IBOutlet weak var collectionView: UICollectionView!

    private func configureDataSource() -> RxCollectionViewSectionedReloadDataSource<WalletItemSection> {
        return RxCollectionViewSectionedReloadDataSource<WalletItemSection>(
            configureCell: { dataSource, collectionView, indexPath, content in
                switch dataSource[indexPath] {
                case .Add:
                    let cell: WalletItemEmptyCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                    return cell
                case .Wallet(let items):
                    let cell: WalletItemCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                    cell.configure(with: items)
                    return cell
                }
        },
        configureSupplementaryView: { _, _, _, _  in UICollectionReusableView() }
        )
    }
}

extension WalletItemViewController: ViewModelBindable {
    typealias ViewModel = WalletItemViewModel

    func bindViewModel(viewModel: ViewModel) {
        let dataSource = configureDataSource()

        let input = WalletItemViewModel.Input(
            viewWillAppear: rx.viewWillAppear.asDriver()
        )

        let output = viewModel.build(input: input)

        output
            .walletItems
            .drive { $0 }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
