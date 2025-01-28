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
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        Image("placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    @unknown default:
                        Image("placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .frame(width: 100, height: 100)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

                HStack {
                    Button(action: {
                        cartManager.removeFromCart(product: product)
                    }) {
                        Image(systemName: "minus")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 30, height: 30)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(6)
                    }

                    Text("\(quantity)")
                        .font(.system(size: 16, weight: .bold))
                        .frame(width: 30)

                    Button(action: {
                        cartManager.addToCart(product: product)
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 30, height: 30)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(6)
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

                    Button(action: {
                        cartManager.removeProductCompletely(product: product)
                    }) {
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
        .padding()
        .frame(height: 200)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
