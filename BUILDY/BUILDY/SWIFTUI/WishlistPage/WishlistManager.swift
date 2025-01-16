//
//  WishlistManager.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 16.01.25.
//


import Foundation
import SwiftUI

class WishlistManager: ObservableObject {
    
    static let shared = WishlistManager()
    @Published var wishlist: [Product] = []

    private init() {}

    func addToWishlist(product: Product) {
        if !wishlist.contains(where: { $0.codeID == product.codeID }) {
            wishlist.append(product)
        }
    }

    func removeFromWishlist(product: Product) {
        wishlist.removeAll { $0.codeID == product.codeID }
    }

    func isInWishlist(product: Product) -> Bool {
        return wishlist.contains { $0.codeID == product.codeID }
    }
}


