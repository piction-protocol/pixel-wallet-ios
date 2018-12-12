//
//  Notification.Name+Extension.swift
//  pixelwallet-ios
//
//  Created by jhseo on 07/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let willEnterForeground = Notification.Name(rawValue: "applicationWillEnterForeground")
    static let didEnterBackground = Notification.Name(rawValue: "applicationDidEnterBackground")
}
