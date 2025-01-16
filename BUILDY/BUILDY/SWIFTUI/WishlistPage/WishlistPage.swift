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
            VStack {
                if wishlistManager.wishlist.isEmpty {
                    Text("Your Wishlist is empty!")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(wishlistManager.wishlist, id: \.codeID) { item in
                                ProductCard(product: item)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Wishlist")
            .onAppear {
                print("WishlistPage appeared")
            }
        }
    }
}

struct ProductCard: View {
    let product: Product
    
    var body: some View {
        VStack {
            Image(uiImage: product.imageURL ?? (UIImage(named: "placeholder") ?? UIImage()))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Text(product.name)
                .font(.body)
                .fontWeight(.medium)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    WishlistPage()
}
