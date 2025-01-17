//
//  CartProductCard.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 16.01.25.
//

import SwiftUI

struct CartProductCard: View {
    let product: Product
    let quantity: Int
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        HStack {
            Image(uiImage: product.imageURL ?? (UIImage(named: "placeholder") ?? UIImage()))
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                Text("\(product.price)")
                    .font(.subheadline)
                    .foregroundColor(.orange)
                Text("Qty: \(quantity)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            HStack {
                Button(action: {
                    cartManager.removeFromCart(product: product)
                }) {
                    Image(systemName: "minus.circle")
                        .foregroundColor(.orange)
                }

                Button(action: {
                    cartManager.addToCart(product: product)
                }) {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.orange)
                }
            }
        }
        .padding(.vertical, 10)
    }
}
