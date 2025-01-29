//
//  ProductCart.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 16.01.25.
//

import SwiftUI

struct ProductCard: View {
    let product: Product
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var wishlistManager: WishlistManager
    @State private var showDeleteAlert = false

    var body: some View {
        HStack(spacing: 12) {
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
            .frame(width: 80, height: 80)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
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

            VStack(spacing: 6) {
                Button(action: {
                    cartManager.addToCart(product: product)
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "cart")
                        Text("Add to cart")
                    }
                    .font(.system(size: 14, weight: .medium))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .foregroundColor(.black)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }

                Button(action: {
                    withAnimation {
                        showDeleteAlert.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        wishlistManager.removeFromWishlist(product: product)
                    }
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)

        if showDeleteAlert {
            DeleteAlert()
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .top).combined(with: .opacity),
                        removal: .move(edge: .top).combined(with: .opacity)
                    )
                )
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            showDeleteAlert = false
                        }
                    }
                }
        }
    }
}
