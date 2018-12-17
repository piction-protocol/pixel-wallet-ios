//
//  WalletDatabaseModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 14/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RealmSwift

class WalletDatabaseModel: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var network: Int = 0

    convenience init(name: String, address: String, network: Int) {
        self.init()
        self.name = name
        self.address = address
        self.network = network
    }

    override static func primaryKey() -> String? {
        return "address"
    }
}
