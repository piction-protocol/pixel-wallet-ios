//
//  KeychainStorage.swift
//  pixelwallet-ios
//
//  Created by jhseo on 10/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import KeychainAccess

final class KeychainStorage {
    enum Service: String {
        case privateKey = "com.piction.privatekey"
    }

    init() {
    }

    private static var accessGroup: String {
        guard let prefix = Bundle.main.object(forInfoDictionaryKey: "AppIdentifierPrefix") as? String else {
            fatalError("AppIdentifierPrefix is not found in Info.plist")
        }
        return prefix + keyChainGroupId
    }

    private static func keychain(forService service: Service) -> Keychain {
        return Keychain(service: service.rawValue, accessGroup: accessGroup)
    }

    subscript(service: Service) -> String? {
        get {
            return KeychainStorage.keychain(forService: service)[keyChainGroupId]
        }
        set {
            KeychainStorage.keychain(forService: service)[keyChainGroupId] = newValue
        }
    }

    func clearKeychain() {
        self[.privateKey] = nil
    }
}
