//
//  UIViewController+Extension.swift
//  pixelwallet-ios
//
//  Created by jhseo on 03/12/2018.
//  Copyright © 2018 Piction Network. All rights reserved.
//

import UIKit

enum ViewOpenType: Int {
    case present
    case push
}

extension UIViewController {
    public static var defaultNib: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }

    public static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }

    func openViewController(_ childView: UIViewController, type: ViewOpenType) {
        switch type {
        case .present:
            let navigation = UINavigationController(rootViewController: childView)
            self.present(navigation, animated: true, completion: nil)
        case .push:
            self.navigationController?.pushViewController(childView, animated: true)
        }
    }
}

extension UIViewController {
    func embed(_ childViewController: UIViewController, to view: UIView) {
        childViewController.view.frame = view.bounds
        view.addSubview(childViewController.view)
        addChildViewController(childViewController)
        childViewController.didMove(toParentViewController: self)
    }

    func remove(_ childViewController: UIViewController) {
        childViewController.willMove(toParentViewController: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParentViewController()
    }
}
