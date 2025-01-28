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
                if wishlistManager.wishlist.isEmpty {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFit()
                        .foregroundColor(.black)
                        .padding(.bottom)
                    Text("Your Wishlist is empty!")
                        .font(.headline)
                        .foregroundColor(.black)
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

