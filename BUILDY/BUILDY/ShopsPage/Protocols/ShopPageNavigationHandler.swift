//
//  ShopPageNavigationHandler.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 16.01.25.
//

import UIKit
import SwiftUI

protocol ShopPageNavigation {
    func navigateToProductDetails(from viewController: UIViewController, with product: Product)
}

class ShopPageNavigationHandler: ShopPageNavigation {
    
    func navigateToProductDetails(from viewController: UIViewController, with product: Product) {
        let productDetailsView = ProductDetailsView(product: product)
            .environmentObject(WishlistManager.shared)
            .environmentObject(CartManager.shared)
        
        let hostingController = UIHostingController(rootView: productDetailsView)
        
        viewController.navigationController?.pushViewController(hostingController, animated: true)
    }
}
