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
    @Environment(\.presentationMode) var presentationMode
    @State private var quantity: Int = 1
    @State private var showFullFeatures: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.title2)
                }
                Spacer()
                Text(product.supplier)
                    .font(.headline)
                Spacer()
                Spacer()
            }
            .padding()
            
            ScrollView {
                VStack(spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                        Image(uiImage: product.imageURL ?? (UIImage(named: "placeholder") ?? UIImage()))
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                    .frame(height: 250)
                    .padding(.horizontal)
                    
                    ProductInfoView(product: product, showFullFeatures: $showFullFeatures)
                    
                    HStack(spacing: 16) {
                        Button(action: {
                            if quantity > 1 { quantity -= 1 }
                        }) {
                            Image(systemName: "minus")
                                .font(.title3)
                                .foregroundColor(.black)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        
                        Text("\(quantity)")
                            .font(.title3)
                            .fontWeight(.medium)
                        
                        Button(action: {
                            quantity += 1
                        }) {
                            Image(systemName: "plus")
                                .font(.title3)
                                .foregroundColor(.black)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        
                        Spacer()
                        
                        Text("Pc")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Button(action: {
                            wishlistManager.addToWishlist(product: product)
                        }) {
                            Text("Add to Wishlist")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(12)
                        }
                        
                        Button(action: {
                            cartManager.addToCart(product: product)
                        }) {
                            Text("Add to Cart")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

