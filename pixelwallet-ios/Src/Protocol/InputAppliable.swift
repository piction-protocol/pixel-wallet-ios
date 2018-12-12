//
//  InputAppliable.swift
//  pixelwallet-ios
//
//  Created by jhseo on 06/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

protocol InputAppliable {
    associatedtype Input
    func apply(input: Input)
}

extension InputAppliable {
    func applied(input: Input) -> Self {
        apply(input: input)
        return self
    }
}
