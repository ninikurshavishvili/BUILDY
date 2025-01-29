//
//  CartPage.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 14.01.25.
//


import SwiftUI

struct CartPage: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var showCheckoutPopup = false

    var body: some View {
        NavigationStack {
            VStack {
                if cartManager.cartItems.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "bag.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFit()
                            .foregroundColor(.black)
                            .padding(.bottom)

                        Text("Your Cart is empty.")
                            .font(.headline)
                            .foregroundColor(.black)

                        Text("Add your favourite items to cart for fast checkout")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                    }
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

                if !cartManager.cartItems.isEmpty {
                    HStack {
                        Text("Total: \(cartManager.getTotalPrice(), specifier: "%.2f") ₾")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                        NavigationLink(
                            destination: AddPaymentView(),
                            label: {
                                Text("Checkout")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black)
                                    .cornerRadius(8)
                            })
                    }
                    .padding()
                }
            }
            .navigationTitle("Shopping Cart")
            .onAppear {
                cartManager.fetchCartFromFirestore()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}


