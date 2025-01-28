//
//  Untitled.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 21.01.25.
//

import SwiftUI

struct PlaceOrderView: View {
    @State private var deliveryAddress: String = "46 Ateni street 16, Tbilisi"
    @State private var paymentMethod: String = "Add new card"
    var cartItems: [Product: Int]
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                }
                Spacer()
                Text("Place order")
                    .font(.headline)
                Spacer()
                Text("\(cartItems.values.reduce(0, +)) Items")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "shippingbox.fill")
                        .foregroundColor(.green)
                    Text("Delivery address")
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                Text(deliveryAddress)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                HStack {
                    Image(systemName: "info.circle")
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.orange)
                        .clipShape(Circle())
                    Text("Delivery may take between 1 and 3 days, depending on the order size.")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.orange)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding(.horizontal)

            NavigationLink(destination: PaymentMethodView()) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "creditcard.fill")
                            .foregroundColor(.gray)
                        Text("Payment method")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    Text(paymentMethod)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding(.horizontal)

            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding(.horizontal)

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(Array(cartItems.keys), id: \.codeID) { product in
                        if let quantity = cartItems[product] {
                            HStack {
                                AsyncImage(url: product.linkToURL) { image in
                                    image.resizable()
                                } placeholder: {
                                    Image("placeholder")
                                        .resizable()
                                        .scaledToFit()
                                }
                                .frame(width: 60, height: 60)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)

                                VStack(alignment: .leading) {
                                    Text(product.name)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                    Text(product.price)
                                        .font(.subheadline)
                                        .foregroundColor(.orange)
                                    Text("\(quantity) Pcs")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                        }
                    }
                }
                .padding(.horizontal)
            }

            Spacer()
        }
        .background(Color.gray.opacity(0.1))
        .navigationBarHidden(true)
    }
}
