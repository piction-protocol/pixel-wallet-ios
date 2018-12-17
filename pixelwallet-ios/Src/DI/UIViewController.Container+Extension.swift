//
//  UIViewController.Container+Extension.swift
//  pixelwallet-ios
//
//  Created by jhseo on 05/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import Swinject
import UIKit

extension RootViewController {
    static func make() -> RootViewController {
        return Container.shared.resolve(RootViewController.self)!
    }
}

extension WalletListViewController {
    static func make() -> WalletListViewController {
        return Container.shared.resolve(WalletListViewController.self)!
    }
}

extension NewWalletViewController {
    static func make() -> NewWalletViewController {
        return Container.shared.resolve(NewWalletViewController.self)!
    }
}

extension WalletItemViewController {
    static func make() -> WalletItemViewController {
        return Container.shared.resolve(WalletItemViewController.self)!
    }
}

extension AddWalletViewController {
    static func make() -> AddWalletViewController {
        return Container.shared.resolve(AddWalletViewController.self)!
    }
}

extension SelectNetworkViewController {
    static func make(type: AddWalletType) -> SelectNetworkViewController {
        return Container.shared.resolve(SelectNetworkViewController.self, argument: type)!
    }
}

extension ImportWalletViewController {
    static func make() -> ImportWalletViewController {
        return Container.shared.resolve(ImportWalletViewController.self)!
    }
}

extension WalletInfoViewController {
    static func make() -> WalletInfoViewController {
        return Container.shared.resolve(WalletInfoViewController.self)!
    }
}

extension AddWalletCompleteViewController {
    static func make() -> AddWalletCompleteViewController {
        return Container.shared.resolve(AddWalletCompleteViewController.self)!
    }
}

extension SettingViewController {
    static func make() -> SettingViewController {
        return Container.shared.resolve(SettingViewController.self)!
    }
}
