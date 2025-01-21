//
//  WishlistPage.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 14.01.25.
//

import SwiftUI

struct WishlistPage: View {
    @EnvironmentObject var wishlistManager: WishlistManager

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(["All", "Accessories", "Electric Kettles"], id: \.self) { category in
                            Button(action: {
                            }) {
                                Text(category)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(category == "All" ? Color.black : Color.gray.opacity(0.2))
                                    .foregroundColor(category == "All" ? .white : .black)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                if wishlistManager.wishlist.isEmpty {
                    Text("Your Wishlist is empty!")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(wishlistManager.wishlist, id: \.codeID) { item in
                                ProductCard(product: item)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Wishlist")
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

