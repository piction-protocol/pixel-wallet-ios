//
//  RealmManager.swift
//  pixelwallet-ios
//
//  Created by jhseo on 14/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import Realm
import RealmSwift
import RxSwift
import EthereumKit

protocol RealmManagerProtocol {
    var realm: Realm { get }
    func getWalletList() -> [WalletItemModel]
    func getWalletCount() -> Int
    func insertWalletItem(name: String, address: String, network: Network)
}

final class RealmManager: RealmManagerProtocol {

    private static let schemaVersion: UInt64 = 1

    let realm: Realm

    init() {
        RealmManager.migrateIfNeeded()

        let realm: Realm
        do {
            realm = try Realm()
        } catch {
            fatalError("Could not instantiate Realm: \(error)")
        }

        self.realm = realm
    }

    private static func migrateIfNeeded() {
        let config = Realm.Configuration(schemaVersion: schemaVersion)
        Realm.Configuration.defaultConfiguration = config
    }

    func getWalletList() -> [WalletItemModel] {
        let result = realm.objects(WalletDatabaseModel.self)

        var walletItems: [WalletItemModel] = []

        result.forEach { model in
            let item = WalletItemModel(name: model.name, address: model.address, network: Network(rawValue: model.network)!, balance: Balance(wei: 0))
            walletItems.append(item)
        }

        return walletItems
    }

    func getWalletCount() -> Int {
        let result = realm.objects(WalletDatabaseModel.self)

        return result.count
    }

    func insertWalletItem(name: String, address: String, network: Network) {
        let walletItem = WalletDatabaseModel(name: name, address: address, network: network.rawValue)
        try! realm.write {
            realm.add(walletItem, update: true)
        }
    }

    func removeAllWalletItems() {
        let result = realm.objects(WalletDatabaseModel.self)

        try! realm.write {
            if !result.isEmpty {
                realm.delete(result)
            }
        }
    }

    func removeWalletItem(address: String) {
        let result = realm.objects(WalletDatabaseModel.self)
            .filter("address = %@", address as Any)

        try! realm.write {
            if !result.isEmpty {
                realm.delete(result)
            }
        }
    }
}
