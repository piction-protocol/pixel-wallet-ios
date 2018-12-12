//
//  Injectable.swift
//  pixelwallet-ios
//
//  Created by jhseo on 05/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

protocol Injectable {
    associatedtype Dependency
    init(dependency: Dependency)
}
