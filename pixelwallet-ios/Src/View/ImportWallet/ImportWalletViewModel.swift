//
//  ImportWalletViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 10/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyJSON
import EthereumKit

final class ImportWalletViewModel: InjectableViewModel {
    typealias Dependency = (
        KeychainStorage,
        RealmManager,
        UpdaterProtocol
    )

    private let keychain: KeychainStorage
    private let realmManager: RealmManager
    private let updater: UpdaterProtocol

    init(dependency: Dependency) {
        (keychain, realmManager, updater) = dependency
    }

    struct Input {
        let importButtonDidTap: Driver<Void>
        let privateKeyTextFieldDidInput: Driver<String>
    }

    struct Output {
        let openWalletInfo: Driver<Void>
    }

    func build(input: Input) -> Output {
        let realm = realmManager
        let openWalletInfo = input.importButtonDidTap
            .withLatestFrom(input.privateKeyTextFieldDidInput)
            .flatMapLatest { [weak self] privateKey -> Driver<Void> in
                guard privateKey.validateHex() else {
                    return Driver.empty()
                }

                do {
                    var json: JSON

                    let keychainData = self?.keychain[.privateKey]
                    if let data = keychainData?.data(using: String.Encoding.utf8) {
                        let dict = try JSONSerialization.jsonObject(with: data, options: [])
                        json = JSON(dict)
                    } else {
                        json = JSON(keychainData)
                    }

                    let importWallet = try Wallet(network: Network.piction.chain, privateKey: privateKey, debugPrints: true)

                    let address = importWallet.address()

                    let importAccountJson = JSON(["accounts": [["address": "\(address)", "privateKey": privateKey]]])

                    if json.exists() {
                        try json.merge(with: importAccountJson)
                    } else {
                        json = importAccountJson
                    }
                    self?.keychain[.privateKey] = json.rawString()

                    let accountCount = realm.getWalletCount()
                    realm.insertWalletItem(name: "My Account \(accountCount + 1)", address: address, network: .piction)

                    self?.updater.refreshWallet.onNext(())

                    print(json)
                } catch let error {
                    print(error)
                }

                return input.importButtonDidTap
            }

        return Output(
            openWalletInfo: openWalletInfo
        )
    }
}

