//
//  PaymentMethodView.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 23.01.25.
//


import SwiftUI

struct PaymentMethodView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var cardNumber: String = ""
    @State private var cardHolderName: String = ""
    @State private var expiryDate: String = ""
    @State private var cvv: String = ""

    var body: some View {
        VStack(spacing: 20) {
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
                Text("Add Payment Method")
                    .font(.headline)
                Spacer()
            }
            .padding()

            TextField("Card Number", text: $cardNumber)
                .keyboardType(.numberPad)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)

            TextField("Cardholder Name", text: $cardHolderName)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)

            HStack {
                TextField("Expiry Date (MM/YY)", text: $expiryDate)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                TextField("CVV", text: $cvv)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .frame(width: 100)
            }

            Button(action: {
                savePaymentMethod()
            }) {
                Text("Save Card")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.1).ignoresSafeArea())
    }

    private func savePaymentMethod() {
        print("Card Saved: \(cardNumber)")
        presentationMode.wrappedValue.dismiss()
    }
}
