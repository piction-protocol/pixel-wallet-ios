//
//  Network.swift
//  pixelwallet-ios
//
//  Created by jhseo on 11/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import EthereumKit

enum Network: Int {
    case piction
    case ropsten
    case ethereum

    var symbol: String {
        switch self {
        case .ethereum,
             .ropsten:
            return "ETH"
        case .piction:
            return "PXL"
        }
    }

    var description: String {
        switch self {
        case .ethereum:
            return "ETHEREUM MAINNET"
        case .ropsten:
            return "ETHEREUM ROPSTEN"
        case .piction:
            return "PICTION NETWORK"
        }
    }

    var image: UIImage {
        switch self {
        case .ethereum,
             .ropsten:
            return #imageLiteral(resourceName: "ethereum_logo")
        case .piction:
            return #imageLiteral(resourceName: "piction_logo")
        }
    }

    var rpcURL: String {
        switch self {
        case .ethereum:
            return ""
        case .ropsten:
            return ""
        case .piction:
            return "https://private.piction.network:8545"
        }
    }

    var chain: EthereumKit.Network {
        switch self {
        case .ethereum:
            return EthereumKit.Network(name: "main")!
        case .ropsten:
            return EthereumKit.Network(name: "ropsten")!
        case .piction:
            return EthereumKit.Network.private(chainID: 2880, testUse: false)
        }
    }
}
