//
//  CustomNavigationController.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 21.01.25.
//


import UIKit

class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.topItem?.hidesBackButton = true
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.hidesBackButton = true
        super.pushViewController(viewController, animated: animated)
    }
}
