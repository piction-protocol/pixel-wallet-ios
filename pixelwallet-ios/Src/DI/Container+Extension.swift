//
//  Container+Extension.swift
//  pixelwallet-ios
//
//  Created by jhseo on 05/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import Swinject

extension Container {
    static let shared = assembler.resolver

    private static let assembler = Assembler([
        ViewControllerAssembly(),
        ViewModelAssembly(),
        UtilityAssembly()
    ])
}
