//
//  WalletInfoViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 10/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyJSON

final class WalletInfoViewModel: InjectableViewModel {
    typealias Dependency = (
        KeychainStorage,
        RealmManager,
        Int
    )

    private let keychain: KeychainStorage
    private let realm: RealmManager
    private let walletIndex: Int

    init(dependency: Dependency) {
        (keychain, realm, walletIndex) = dependency
    }

    struct Input {
        let viewWillAppear: Driver<Void>
    }

    struct Output {
        let walletInfoItem: Driver<WalletInfoModel>
    }

    func build(input: Input) -> Output {
        let index = self.walletIndex
        let walletInfoItem = input.viewWillAppear
            .flatMapLatest { [weak self] _ -> Driver<WalletInfoModel> in
                do {
                    var json: JSON

                    let keychainData = self?.keychain[.privateKey]
                    if let data = keychainData?.data(using: String.Encoding.utf8) {
                        let dict = try JSONSerialization.jsonObject(with: data, options: [])
                        json = JSON(dict)
                    } else {
                        json = JSON(keychainData)
                    }
                    let address = json["accounts"][index]["address"].stringValue
                    let privateKey = json["accounts"][index]["privateKey"].stringValue

                    let walletInfo = WalletInfoModel(address: address, privateKey: privateKey, network: .piction)
                    return Driver.just(walletInfo)
                } catch let error {
                    print(error)
                    return Driver.empty()
                }
            }

        return Output(
            walletInfoItem: walletInfoItem
        )
    }
}
