//
//  UITableView+Rx.swift
//  pixelwallet-ios
//
//  Created by jhseo on 06/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit
import RxSwift

extension Reactive where Base: UITableView {
    func items<S: Sequence, Cell: UITableViewCell, O: ObservableType>(cellIdentifier: String = String(describing: Cell.self), cellType: Cell.Type) -> (O) -> (Disposable)
        where O.E == S, Cell: InputAppliable, Cell.Input == S.Iterator.Element {
            return { source in
                let binder: (Int, Cell.Input, Cell) -> Void = { $2.apply(input: $1) }
                return self.items(cellIdentifier: cellIdentifier, cellType: cellType)(source)(binder)
            }
    }
}
