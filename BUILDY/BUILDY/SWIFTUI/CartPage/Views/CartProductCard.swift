//
//  CartProductCard.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 16.01.25.
//

import SwiftUI

struct CartProductCard: View {
    let product: Product
    let quantity: Int
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var wishlistManager: WishlistManager


    var body: some View {
        HStack(spacing: 12) {
            VStack {
                AsyncImage(url: product.linkToURL) { phase in
                    switch phase {
                    case .empty:
                        Image("placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .modifier(ProductImageModifier())
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .modifier(ProductImageModifier())
                    case .failure:
                        Image("placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .modifier(ProductImageModifier())
                    @unknown default:
                        Image("placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .modifier(ProductImageModifier())
                    }
                }

                HStack {
                    Button(action: { cartManager.removeFromCart(product: product) }) {
                        Image(systemName: "minus")
                            .modifier(QuantityButtonModifier())
                    }

                    Text("\(quantity)")
                        .font(.system(size: 16, weight: .bold))
                        .frame(width: 30)

                    Button(action: { cartManager.addToCart(product: product) }) {
                        Image(systemName: "plus")
                            .modifier(QuantityButtonModifier())
                    }
                }

                Text("Pc")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(product.name)
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(2)

                Text("by \(product.supplier)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)

                Text(product.price)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
            }

            Spacer()

            VStack {
                HStack(spacing: 12) {
                    Button(action: {
                        if wishlistManager.isInWishlist(product: product) {
                            wishlistManager.removeFromWishlist(product: product)
                        } else {
                            wishlistManager.addToWishlist(product: product)
                        }
                    }) {
                        Image(systemName: wishlistManager.isInWishlist(product: product) ? "heart.fill" : "heart")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }

                    Button(action: { cartManager.removeProductCompletely(product: product) }) {
                        Image(systemName: "trash")
                            .font(.system(size: 16))
                            .foregroundColor(.red)
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
            }
        }
        .modifier(CardModifier())
    }
}

