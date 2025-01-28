//
//  WishlistManager.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 16.01.25.
//


import Foundation
import FirebaseFirestore
import FirebaseAuth

final class WishlistManager: ObservableObject {
    
    static let shared = WishlistManager()
    @Published var wishlist: [Product] = []

    private let db = Firestore.firestore()
    
    private var userID: String? {
        return Auth.auth().currentUser?.uid
    }

    private init() {}

    func addToWishlist(product: Product) {
        guard !wishlist.contains(where: { $0.codeID == product.codeID }) else { return }
        
        wishlist.append(product)
        saveToFirestore(product: product)
    }

    func removeFromWishlist(product: Product) {
        wishlist.removeAll { $0.codeID == product.codeID }
        deleteFromFirestore(product: product)
    }

    func isInWishlist(product: Product) -> Bool {
        return wishlist.contains { $0.codeID == product.codeID }
    }

    private func saveToFirestore(product: Product) {
        guard let userID = userID else { return }

        let productData: [String: Any] = [
            "name": product.name,
            "price": product.price,
            "quantity": 1,
            "unit": product.unit,
            "featuresGeo": product.featuresGeo,
            "category": product.category,
            "link": product.link ?? "",
            "supplier": product.supplier
        ]

        db.collection("users")
            .document(userID)
            .collection("wishlist")
            .document(product.codeID)
            .setData(productData) { error in
                if let error = error {
                    print("Error saving product to wishlist in Firestore: \(error.localizedDescription)")
                } else {
                    print("Product added to wishlist: \(product.name)")
                }
            }
    }

    private func deleteFromFirestore(product: Product) {
        guard let userID = userID else { return }

        db.collection("users")
            .document(userID)
            .collection("wishlist")
            .document(product.codeID)
            .delete { error in
                if let error = error {
                    print("Error removing product from wishlist in Firestore: \(error.localizedDescription)")
                } else {
                    print("Product removed from wishlist: \(product.name)")
                }
            }
    }

    func fetchWishlistFromFirestore() {
        guard let userID = userID else { return }

        db.collection("users")
            .document(userID)
            .collection("wishlist")
            .getDocuments { [weak self] snapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching wishlist: \(error.localizedDescription)")
                    return
                }

                guard let documents = snapshot?.documents else { return }

                self.wishlist.removeAll()
                for document in documents {
                    let data = document.data()
                    if let name = data["name"] as? String,
                       let price = data["price"] as? String,
                       let unit = data["unit"] as? String,
                       let featuresGeo = data["featuresGeo"] as? String,
                       let category = data["category"] as? String,
                       let link = data["link"] as? String,
                       let supplier = data["supplier"] as? String {
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
                        self.wishlist.append(product)
                    }
                }
            }
    }
}


