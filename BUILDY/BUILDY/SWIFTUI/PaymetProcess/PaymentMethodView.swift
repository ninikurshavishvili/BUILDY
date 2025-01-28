//
//  PaymentMethodView.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 23.01.25.
//


import SwiftUI

struct PaymentMethodView: View {
    @StateObject private var cardManager = AddCardManager()
    @State private var showPaymentConfirmation = false
    @State private var navigateToDeliveryStatus = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "cart.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
                
                Spacer()
                
                Text("Total: 0.00 ₾")
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
                Text("Save Card (0.00 ₾)")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Button(action: {
                showPaymentConfirmation = true
            }) {
                Text("Confirm & Pay")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .alert(isPresented: $showPaymentConfirmation) {
                Alert(
                    title: Text("Payment Confirmed"),
                    message: Text("Your payment has been successfully processed."),
                    dismissButton: .default(Text("OK"), action: {
                        navigateToDeliveryStatus = true
                    })
                )
            }
            
            NavigationLink(
                destination: DeliveryStatusView(),
                isActive: $navigateToDeliveryStatus,
                label: { EmptyView() }
            )
            
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
    }
}
