//
//  SelectNetworkViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 10/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyJSON
import EthereumKit

final class SelectNetworkViewModel: InjectableViewModel {
    typealias Dependency = (
        KeychainStorage,
        RealmManager,
        AddWalletType
    )

    private var keychain: KeychainStorage
    private let realmManager: RealmManager
    private let addWalletType: AddWalletType

    init(dependency: Dependency) {
        (keychain, realmManager, addWalletType) = dependency
    }

    struct Input {
        let itemSelected: Driver<IndexPath>
    }

    struct Output {
        let addWalletType: Driver<AddWalletType>
        let selectedIndexPath: Driver<IndexPath>
    }

    func build(input: Input) -> Output {
        let realm = realmManager
        let addWalletType = self.addWalletType
        let selectedIndexPath = input.itemSelected
            .flatMapLatest { [weak self] indexPath -> Driver<IndexPath> in
                if addWalletType == .create {
                    do {
                        var json: JSON

                        let keychainData = self?.keychain[.privateKey]
                        if let data = keychainData?.data(using: String.Encoding.utf8) {
                            let dict = try JSONSerialization.jsonObject(with: data, options: [])
                            json = JSON(dict)
                        } else {
                            json = JSON(keychainData)
                        }

                        let seed = try Mnemonic.createSeed(mnemonic: Mnemonic.create())
                        let newWallet = try Wallet(seed: seed, network: Network.piction.chain, debugPrints: true)

                        let address = newWallet.address()

                        let importAccountJson = JSON(["accounts": [["address": "\(address)", "privateKey": newWallet.privateKey().toHexString()]]])

                        if json.exists() {
                            try json.merge(with: importAccountJson)
                        } else {
                            json = importAccountJson
                        }

                        self?.keychain[.privateKey] = json.rawString()

                        let accountCount = realm.getWalletCount()
                        realm.insertWalletItem(name: "My Account \(accountCount + 1)", address: address, network: .piction)

                        print(json)

                    } catch let error {
                        print(error)
                    }
                }
                return Driver.just(indexPath)
            }

        return Output(
            addWalletType: Driver.just(addWalletType),
            selectedIndexPath: selectedIndexPath
        )
    }
}
