//
//  TabBarController.swift
//  pixelwallet-ios
//
//  Created by jhseo on 14/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit
import RxSwift
import Swinject

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar(with: TabBarItem.all)
    }

    private func setTabBar(with types: [TabBarItem]) {
        viewControllers = types.map { item -> UIViewController in
            let viewController = item.makeViewController()
            return viewController
        }
    }
}

enum TabBarItem {
    case wallet
    case setting

    static var all: [TabBarItem] {
        return [.wallet, .setting]
    }
}

extension TabBarItem {
    private func makeTabBarItem() -> UITabBarItem {
        let items: (String, UIImage?, UIImage?)

        switch self {
        case .wallet:
            items = (
                "Wallet",
                nil,
                nil
            )

        case .setting:
            items = (
                "Setting",
                nil,
                nil
            )
        }

        let tabBarItem = UITabBarItem(
            title: items.0,
            image: items.1,
            selectedImage: items.2
        )

        return tabBarItem
    }

    fileprivate func makeViewController() -> UIViewController {
        let viewController: UIViewController

        switch self {
        case .wallet:
            viewController = WalletListViewController.make()

        case .setting:
            viewController = SettingViewController.make()
        }

        viewController.tabBarItem = makeTabBarItem()
        return viewController
    }
}
