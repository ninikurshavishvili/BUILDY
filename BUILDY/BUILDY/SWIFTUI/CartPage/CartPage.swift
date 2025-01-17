//
//  CartPage.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 14.01.25.
//


import SwiftUI

struct CartPage: View {
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        NavigationView {
            VStack {
                if cartManager.cartItems.isEmpty {
                    Text("Your cart is empty.")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(Array(cartManager.cartItems.keys), id: \.codeID) { product in
                                if let quantity = cartManager.cartItems[product] {
                                    CartProductCard(product: product, quantity: quantity)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                HStack {
                    Text("Total: \(cartManager.getTotalPrice(), specifier: "%.2f") ₾")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {

                    }) {
                        Text("Checkout")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationTitle("Shopping Cart")
        }
    }
}

