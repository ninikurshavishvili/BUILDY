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
                                .imageScale(.large)
                                .padding()
                        }
                        Spacer()
                    }
                    .padding(.leading)

                    HStack {
                        Image("TBC")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
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

                        VStack {
                            HStack {
                                TextField("Card Number", text: $cardManager.cardNumber)
                                    .keyboardType(.numberPad)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                    .frame(maxWidth: .infinity)

                                Image("visa")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                Image("american-express")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                Image("master-card")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)

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
                            .background(.gray)
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
                        Text("Confirm & Pay (\(cartManager.getTotalPrice(), specifier: "%.2f") ₾)")
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.customOrange)
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
                .navigationBarHidden(true)

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
        }
    }
}

