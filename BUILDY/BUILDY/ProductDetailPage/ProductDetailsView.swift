//
//  ProductDetailsView.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 14.01.25.
//

import SwiftUI

struct ProductDetailsView: View {
    let product: Product

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(uiImage: product.imageURL ?? (UIImage(named: "placeholder") ?? UIImage()))
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 300)
                    .cornerRadius(8)
                    .padding()


                Text(product.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)

                Text("ფასი: \(product.price) \(product.unit)")
                    .font(.headline)
                    .foregroundColor(.orange)
                    .padding(.horizontal)

                Text("მახასიათებლები:")
                    .font(.headline)
                    .padding(.horizontal)
                Text(product.featuresGeo)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                Text("მომწოდებელი: \(product.supplier)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)

                Spacer()
            }
        }
        .navigationTitle(product.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

