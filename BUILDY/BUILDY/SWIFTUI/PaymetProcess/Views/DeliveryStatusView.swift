//
//  DeliveryStatusView.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 24.01.25.
//

import SwiftUI

struct DeliveryStatusView: View {
    @StateObject private var profileManager = ProfileManager()
    @StateObject private var cartManager = CartManager.shared

    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Order Details")
                        .font(.title2)
                        .fontWeight(.bold)

                    Divider()

                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 16) {
                            OrderStatusRecieved(status: "Order Received", icon: "checkmark.circle.fill")
                            OrderStatus(status: "Order Picked Up", icon: "checkmark.circle.fill")
                            OrderStatus(status: "Your Order Is On Delivery", icon: "clock.fill")
                        }

                        HStack {
                            Image(systemName: "house.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 28))
                            Text("Delivery Address")
                                .font(.headline)
                        }
                        Text(profileManager.userAddress.isEmpty ? "Loading..." : profileManager.userAddress)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    Divider()

                    HStack {
                        Image("person")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())

                        VStack(alignment: .leading) {
                            Text("Driver: Jonny")
                                .font(.headline)
                            Text("7ZDX878")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        HStack {
                            Button(action: {}) {
                                Image(systemName: "phone.fill")
                                    .padding()
                                    .background(Color.green.opacity(0.2))
                                    .clipShape(Circle())
                            }
                            Button(action: {}) {
                                Image(systemName: "message.fill")
                                    .padding()
                                    .background(Color.blue.opacity(0.2))
                                    .clipShape(Circle())
                            }
                        }
                    }

                    Divider()
                    Spacer()
                    
                    HStack {
                        Text("Subtotal")
                            .font(.headline)
                        Spacer()
                        Text("\(String(format: "%.2f", cartManager.getTotalPrice()))")
                            .font(.headline)
                    }

                    Button(action: {
                        print("Order canceled")
                    }) {
                        Text("Cancel Order")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Delivery Status")
        .onAppear {
            profileManager.fetchUserProfile()
            cartManager.fetchCartFromFirestore()
        }
    }
}



