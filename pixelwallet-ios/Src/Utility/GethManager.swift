//
//  GethManager.swift
//  pixelwallet-ios
//
//  Created by jhseo on 06/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import RxSwift
import RxCocoa
import EthereumKit

protocol GethManagerProtocol {
    func getBalance(address: String, blockParameter: BlockParameter) -> Single<Balance>
    func getTransactions(address: String) -> Single<Transactions>
    func getTokenBalance(address: String) -> Single<Balance>
}

final class GethManager: GethManagerProtocol, Injectable {
    typealias Dependency = (WalletManagerProtocol)

    private let geth: Geth

    init(dependency: Dependency) {
        let (wallet) = dependency

        let configuration = Configuration(
            network: wallet.network.chain,
            nodeEndpoint: wallet.network.rpcURL,
            etherscanAPIKey: "",
            debugPrints: true
        )

        geth = Geth(configuration: configuration)
    }

    func getBalance(address: String, blockParameter: BlockParameter) -> Single<Balance> {
        return Single.create { [weak geth] observer in
            geth?.getBalance(of: address, blockParameter: blockParameter, completionHandler: { result in
                switch result {
                case .success(let balance):
                    observer(.success(balance))
                case .failure(let error):
                    observer(.error(error))
                }
            })
            return Disposables.create()
        }
    }

    func getTransactions(address: String) -> Single<Transactions> {
        return Single.create { [weak geth] observer in
            geth?.getTransactions(address: address) { result in
                switch result {
                case .success(let transactions):
                    observer(.success(transactions))
                case .failure(let error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    func getTokenBalance(address: String) -> Single<Balance> {
        return Single.create { [weak geth] observer in
            let contract = ERC20(contractAddress: "0x7eB4F1e621c0b4AF03199C2758A3a4C4f5Cd3719", decimal: 18, symbol: "PXL")
            geth?.getTokenBalance(contract: contract, address: address) { result in
                switch result {
                case .success(let balance):
                    observer(.success(balance))
                case .failure(let error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
