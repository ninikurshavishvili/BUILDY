//
//  AddPaymentView.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 24.01.25.
//

import SwiftUI

struct AddPaymentView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
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
                Text("Payment Methods")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)

            Spacer()

            Image(systemName: "creditcard.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding()
                .background(Color.orange)
                .cornerRadius(20)

            Text("Your payment methods list is empty.\nAdd your payment methods for\nfaster check out")
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .font(.body)
                .padding(.horizontal)

            NavigationLink(destination: PaymentMethodView()) {
                Text("Add new card")
                    .foregroundColor(.orange)
                    .fontWeight(.bold)
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .background(Color.white.ignoresSafeArea())
    }
}
