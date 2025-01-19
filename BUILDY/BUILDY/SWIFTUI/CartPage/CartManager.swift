//
//  CartManager.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 16.01.25.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class CartManager: ObservableObject {
    @Published private(set) var cartItems: [Product: Int] = [:]

    static let shared = CartManager()

    private let db = Firestore.firestore()
    
    private var userID: String? {
        return Auth.auth().currentUser?.uid
    }

    func addToCart(product: Product) {
        cartItems[product, default: 0] += 1
        saveToFirestore(product: product)
    }

    func removeFromCart(product: Product) {
        if let currentCount = cartItems[product], currentCount > 1 {
            cartItems[product] = currentCount - 1
            saveToFirestore(product: product)
        } else {
            cartItems.removeValue(forKey: product)
            deleteFromFirestore(product: product)
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

    
    // MARK: - Save in Firestore
    private func saveToFirestore(product: Product) {
        guard let userID = userID else { return }

        let productData: [String: Any] = [
            "name": product.name,
            "price": product.price,
            "quantity": cartItems[product] ?? 1
        ]

        db.collection("users")
            .document(userID)
            .collection("cart")
            .document(product.codeID)
            .setData(productData) { error in
                if let error = error {
                    print("Error saving product to Firestore: \(error.localizedDescription)")
                } else {
                    print("Product saved successfully: \(product.name)")
                }
            }
    }

    // MARK: - Delete from Firestore
    private func deleteFromFirestore(product: Product) {
        guard let userID = userID else { return }

        db.collection("users")
            .document(userID)
            .collection("cart")
            .document(product.codeID)
            .delete { error in
                if let error = error {
                    print("Error deleting product from Firestore: \(error.localizedDescription)")
                } else {
                    print("Product deleted successfully: \(product.name)")
                }
            }
    }
}

