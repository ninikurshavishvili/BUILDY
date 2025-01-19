//
//  CartManager.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 16.01.25.
//

import Foundation
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
            let price = Double(item.key.price.replacingOccurrences(of: "GEL", with: "").replacingOccurrences(of: ",", with: "").trimmingCharacters(in: .whitespaces)) ?? 0.0
            return total + (price * Double(item.value))
        }
    }

    // MARK: - Save in Firestore
    private func saveToFirestore(product: Product) {
        guard let userID = userID else { return }

        let productData: [String: Any] = [
            "category": product.category,
            "featuresGeo": product.featuresGeo,
            "link": product.link ?? "",
            "name": product.name,
            "price": product.price,
            "quantity": cartItems[product] ?? 1,
            "supplier": product.supplier,
            "unit": product.unit
        ]

        db.collection("users")
            .document(userID)
            .collection("cart")
            .document(product.codeID)
            .setData(productData) { error in
                if let error = error {
                    print("Error saving product to Firestore: \(error.localizedDescription)")
                } else {
                    print("Product saved to cart: \(product.name)")
                }
            }
    }

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
                    print("Product removed from cart: \(product.name)")
                }
            }
    }

    func fetchCartFromFirestore() {
        guard let userID = userID else { return }

        db.collection("users")
            .document(userID)
            .collection("cart")
            .getDocuments { [weak self] snapshot, error in
                guard let self = self else { return }

                if let error = error {
                    print("Error fetching cart: \(error.localizedDescription)")
                    return
                }

                guard let documents = snapshot?.documents else { return }

                self.cartItems.removeAll()
                for document in documents {
                    let data = document.data()
                    if let name = data["name"] as? String,
                       let price = data["price"] as? String,
                       let unit = data["unit"] as? String,
                       let featuresGeo = data["featuresGeo"] as? String,
                       let category = data["category"] as? String,
                       let link = data["link"] as? String,
                       let supplier = data["supplier"] as? String,
                       let quantity = data["quantity"] as? Int {
                        let product = Product(
                            name: name,
                            price: price,
                            codeID: document.documentID,
                            unit: unit,
                            featuresGeo: featuresGeo,
                            category: category,
                            link: link,
                            imageURL: nil,
                            supplier: supplier
                        )
                        self.cartItems[product] = quantity
                    }
                }
            }
    }
}


