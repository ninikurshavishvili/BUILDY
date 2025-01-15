//
//  CategoryDetailNavigationHandler.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 15.01.25.
//


import UIKit
import SwiftUI

class CategoryDetailNavigationHandler: CategoryDetailNavigation {
    func navigateToProductDetails(from viewController: UIViewController, with product: Product) {
        let productDetailsView = ProductDetailsView(product: product)
        let hostingController = UIHostingController(rootView: productDetailsView)
        viewController.navigationController?.pushViewController(hostingController, animated: true)
    }
}


protocol CategoryDetailNavigation {
    func navigateToProductDetails(from viewController: UIViewController, with product: Product)
}
