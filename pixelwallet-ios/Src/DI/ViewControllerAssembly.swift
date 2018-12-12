//
//  ViewControllerAssembly.swift
//  pixelwallet-ios
//
//  Created by jhseo on 05/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import Swinject
import UIKit

final class ViewControllerAssembly: Assembly {
    func assemble(container: Container) {

        container.register(WalletListViewController.self) { resolver in
            let vc = Storyboard.WalletList.instantiate(WalletListViewController.self)
            vc.viewModel = resolver.resolve(WalletListViewModel.self)!
            return vc
        }

        container.register(WalletItemViewController.self) { resolver in
            let vc = Storyboard.WalletItem.instantiate(WalletItemViewController.self)
            vc.viewModel = resolver.resolve(WalletItemViewModel.self)!
            return vc
        }

        container.register(AddWalletViewController.self) { resolver in
            let vc = Storyboard.AddWallet.instantiate(AddWalletViewController.self)
            vc.viewModel = resolver.resolve(AddWalletViewModel.self)!
            return vc
        }

        container.register(SelectNetworkViewController.self) { (resolver, type: AddWalletType) in
            let vc = Storyboard.SelectNetwork.instantiate(SelectNetworkViewController.self)
            vc.viewModel = resolver.resolve(SelectNetworkViewModel.self, argument: type)!
            return vc
        }
    }
}
