//
//  ProductDetailsView.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 14.01.25.
//

import SwiftUI

struct ProductDetailsView: View {
    let product: Product
    @EnvironmentObject var wishlistManager: WishlistManager
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(uiImage: product.imageURL ?? (UIImage(named: "placeholder") ?? UIImage()))
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 300)
                    .cornerRadius(8)
                    .padding()
                
                Text(product.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)

                Text("Price: \(product.price) \(product.unit)")
                    .font(.headline)
                    .foregroundColor(.orange)
                    .padding(.horizontal)

                Text("Features:")
                    .font(.headline)
                    .padding(.horizontal)
                Text(product.featuresGeo)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                Text("Supplier: \(product.supplier)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)

                HStack {
                    Button(action: {
                        if wishlistManager.isInWishlist(product: product) {
                            wishlistManager.removeFromWishlist(product: product)
                        } else {
                            wishlistManager.addToWishlist(product: product)
                        }
                    }) {
                        Text(wishlistManager.isInWishlist(product: product) ? "Remove from Wishlist" : "Add to Wishlist")
                            .foregroundColor(.red)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)

                    Spacer()

                    Button(action: {
                        cartManager.addToCart(product: product)
                    }) {
                        Text("Add to Cart")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
        .navigationTitle(product.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
