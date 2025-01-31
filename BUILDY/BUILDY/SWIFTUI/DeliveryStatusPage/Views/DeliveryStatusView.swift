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
    @State private var showCancelAlert = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Order Details")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        OrderStatusRecieved(status: "Order Received", icon: "checkmark.circle.fill")
                        OrderStatus(status: "Order Picked Up", icon: "checkmark.circle.fill")
                        OrderStatus(status: "Your Order Is On Delivery", icon: "clock.fill")
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "house.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 28))
                            Text("Delivery Address")
                                .font(.headline)
                        }
                        Text(profileManager.userAddress.isEmpty ? "No address selected" : profileManager.userAddress)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()

                    Divider()
                    
                    DriverInfoView()
                    
                    Divider()
                    
                    HStack {
                        Text("Subtotal")
                            .font(.headline)
                        Spacer()
                        Text("\(String(format: "%.2f", cartManager.getTotalPrice()))")
                            .font(.headline)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                    
                    Button(action: {
                        showCancelAlert = true
                    }) {
                        Text("Cancel Order")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(16)
                    }
                    .alert(isPresented: $showCancelAlert) {
                        Alert(
                            title: Text("Cancel Order"),
                            message: Text("Do you want to cancel the order?"),
                            primaryButton: .destructive(Text("Yes")) {
                                presentationMode.wrappedValue.dismiss()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                    }
                    .foregroundColor(.black)
                }
            }
        }
        .onAppear {
            profileManager.fetchUserProfile()
            cartManager.fetchCartFromFirestore()
        }
    }
}
