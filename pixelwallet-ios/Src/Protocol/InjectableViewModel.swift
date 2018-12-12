//
//  InjectableViewModel.swift
//  pixelwallet-ios
//
//  Created by jhseo on 05/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    func build(input: Input) -> Output
}

typealias InjectableViewModel = ViewModel & Injectable
