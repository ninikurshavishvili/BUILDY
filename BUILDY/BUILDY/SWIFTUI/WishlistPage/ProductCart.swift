//
//  ProductCart.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 16.01.25.
//

import SwiftUI

struct ProductCart: View {
    let product: Product

    var body: some View {
        HStack(spacing: 15) {
            Image(uiImage: product.imageURL ?? (UIImage(named: "placeholder") ?? UIImage()))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 5) {
                Text(product.name)
                    .font(.headline)
                    .lineLimit(2)

                Text("by \(product.supplier)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text(product.price)
                    .font(.subheadline)
                    .fontWeight(.bold)
            }

            Spacer()

            VStack {
                Button(action: {
                    // MARK: - add to cart logic
                }) {
                    HStack {
                        Image(systemName: "cart")
                        Text("Add to cart")
                    }
                    .font(.system(size: 14, weight: .medium))
                    .padding(6)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(5)
                }

                Button(action: {
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .padding(6)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}
