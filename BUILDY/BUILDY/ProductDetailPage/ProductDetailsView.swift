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

                HStack(spacing: 16) {
                    Button(action: {
                        print("Added \(product.name) to cart.")
                    }) {
                        Text("კალათაში დამატება")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Button(action: {
                        print("Buying \(product.name) now.")
                    }) {
                        Text("ყიდვა")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(product.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


