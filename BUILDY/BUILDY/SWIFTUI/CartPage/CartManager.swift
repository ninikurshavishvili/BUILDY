//
//  CartManager.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 16.01.25.
//

import SwiftUI

class CartManager: ObservableObject {
    @Published private(set) var cartItems: [Product: Int] = [:]

    static let shared = CartManager()

    func addToCart(product: Product) {
        cartItems[product, default: 0] += 1
    }

    func removeFromCart(product: Product) {
        if let currentCount = cartItems[product], currentCount > 1 {
            cartItems[product] = currentCount - 1
        } else {
            cartItems.removeValue(forKey: product)
        }
    }

    func getItemCount(for product: Product) -> Int {
        return cartItems[product] ?? 0
    }

    func getTotalCount() -> Int {
        return cartItems.values.reduce(0, +)
    }
    func getTotalPrice() -> Double {
        return cartItems.reduce(0) { total, item in
            let price = Double(item.key.price) ?? 0.0
            return total + (price * Double(item.value))
        }
    }

}
