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
import RxDataSources

final class WalletListViewController: UIViewController {
    var disposeBag = DisposeBag()

    @IBOutlet weak var collectionView: UICollectionView!

    private func configureDataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, WalletItemModel>> {
        return RxCollectionViewSectionedReloadDataSource<SectionModel<String, WalletItemModel>>(
            configureCell: { dataSource, collectionView, indexPath, model in
                let cell: WalletListCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.configure(with: model)
                return cell
            },
            configureSupplementaryView: { _, collectionView, kind, indexPath  in
                switch kind {
                case UICollectionElementKindSectionHeader:
                    let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "WalletListCollectionHeaderView", for: indexPath)
                    return reusableView
                case UICollectionElementKindSectionFooter:
                    let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "WalletListCollectionFooterView", for: indexPath)
                    let vc = NewWalletViewController.make()
                    self.embed(vc, to: reusableView)
                    return reusableView
                default:
                    return UICollectionReusableView()
                }
            }
        )
    }

    private func openWalletItem(index: Int) {
        let vc = WalletItemViewController.make(index: index)
        if let topViewContrller = UIApplication.topViewController() {
            topViewContrller.openViewController(vc, type: .push)
        }
    }
}

extension WalletListViewController: ViewModelBindable {
    typealias ViewModel = WalletListViewModel

    func bindViewModel(viewModel: ViewModel) {
        let dataSource = configureDataSource()

        let input = WalletListViewModel.Input(
            viewWillAppear: rx.viewWillAppear.asDriver(),
            selectedIndexPath: collectionView.rx.itemSelected.asDriver()
        )

        let output = viewModel.build(input: input)

        output
            .navigationHide
            .drive(onNext: { [weak self] _ in
                self?.navigationController?.setNavigationBarHidden(true, animated: false)
                self?.navigationController?.setNavigationBarLine(false)
            })
            .disposed(by: disposeBag)

        output
            .walletList
            .drive { $0 }
            .map { [SectionModel(model: "", items: $0)] }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        output
            .openWalletItem
            .drive(onNext: { [weak self] indexPath in
                self?.openWalletItem(index: indexPath.row)
            })
            .disposed(by: disposeBag)
    }
}
