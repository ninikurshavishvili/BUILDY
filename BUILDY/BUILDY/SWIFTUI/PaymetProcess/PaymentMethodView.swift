//
//  PaymentMethodView.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 23.01.25.
//

import SwiftUI

struct PaymentMethodView: View {
    @StateObject private var cardManager = AddCardManager()
    @EnvironmentObject var cartManager: CartManager
    @State private var showAlertAnimation = false
    @State private var alertText = "Proceeding to Payment..."
    @State private var navigateToDeliveryStatus = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 20) {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .padding()
                        }
                        Spacer()
                    }
                    .padding(.leading)

                    HStack {
                        Image(systemName: "cart.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()

                        Spacer()

                        Text("Total: \(cartManager.getTotalPrice(), specifier: "%.2f") ₾")
                            .font(.title3)
                            .bold()
                    }
                    .padding()

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Payment Details")
                            .font(.headline)
                            .padding(.leading)

                        HStack {
                            TextField("Card Number", text: $cardManager.cardNumber)
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .frame(maxWidth: .infinity)

                            Image("visa_logo")
                                .resizable()
                                .frame(width: 40, height: 25)
                        }

                        HStack {
                            TextField("MM/YY", text: $cardManager.expiryDate)
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .frame(maxWidth: .infinity)

                            TextField("CVV", text: $cardManager.cvv)
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .frame(width: 80)
                        }
                    }
                    .padding(.horizontal)

                    Button(action: {
                        cardManager.saveUserCard()
                    }) {
                        Text("Save Card")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    Button(action: {
                        showAlertAnimation = true
                        alertText = "Proceeding to Payment..."
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            alertText = "Payment Confirmed ✅"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showAlertAnimation = false
                                navigateToDeliveryStatus = true
                            }
                        }
                    }) {
                        Text("Confirm & Pay")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    Spacer()

                    Text("Data transfer over the internet is secured by TLS.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding()
                }
                .padding(.vertical)
                .onAppear {
                    cardManager.fetchUserCard()
                }

                if showAlertAnimation {
                    VStack {
                        Text(alertText)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(10)

                        if alertText == "Proceeding to Payment..." {
                            ProgressView()
                                .padding(.top, 8)
                        }
                    }
                    .frame(width: 200, height: 100)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .transition(.opacity)
                    .zIndex(1)
                }

                NavigationLink(
                    destination: DeliveryStatusView(),
                    isActive: $navigateToDeliveryStatus
                ) {
                    EmptyView()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

