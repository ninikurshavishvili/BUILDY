//
//  File.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 16.01.25.
//

import Foundation

extension HomePageViewModel {
    func addProductToWishlist(product: Product) {
        WishlistManager.shared.addToWishlist(product: product)
        print("\(product.name) added to wishlist") 
    }
}
