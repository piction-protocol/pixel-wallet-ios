//
//  String+Extension.swift
//  pixelwallet-ios
//
//  Created by jhseo on 11/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import Foundation

extension String {
    func validateHex() -> Bool {
        if self.isEmpty {
            return false
        }

        guard let pattern = try? NSRegularExpression(pattern: "^[A-Za-z0-9+]{64,64}$", options: .caseInsensitive) else {
            return false
        }

        return pattern.matches(in: self, options: [], range: NSRange(location: 0, length: (self as NSString).length)).count > 0
    }

    func isHexString() -> Bool {
        if self.isEmpty {
            return false
        }

        let start = self.index(after: self.startIndex)
        let end = self.index(start, offsetBy: 2)
        let substring = self[start...end]

        return substring == "0x"
    }
}
