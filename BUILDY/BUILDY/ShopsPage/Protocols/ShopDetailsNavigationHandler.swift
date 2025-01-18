//
//  ShopDetailsNavigation.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 18.01.25.
//


import UIKit
import SwiftUI

protocol ShopDetailsNavigation {
    func navigateToProductDetails(from viewController: UIViewController, with product: Product)
}

class ShopDetailsNavigationHandler: ShopDetailsNavigation {
    func navigateToProductDetails(from viewController: UIViewController, with product: Product) {
        let productDetailsView = ProductDetailsView(product: product)
            .environmentObject(WishlistManager.shared)
            .environmentObject(CartManager.shared)

        let hostingController = UIHostingController(rootView: productDetailsView)

        viewController.navigationController?.pushViewController(hostingController, animated: true)
    }
}
