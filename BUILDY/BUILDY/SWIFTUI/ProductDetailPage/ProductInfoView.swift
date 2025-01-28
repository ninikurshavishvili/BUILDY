//
//  ProductInfoView.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 28.01.25.
//

import SwiftUI

struct ProductInfoView: View {
    let product: Product
    @Binding var showFullFeatures: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) { // Align content to the left
            Text(product.name)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .multilineTextAlignment(.leading) // Align name text to the left
            
            Text("\(product.price)")
                .font(.title3)
                .foregroundColor(.black)
                .bold()
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Additional information")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                
                Text(product.featuresGeo)
                    .lineLimit(showFullFeatures ? nil : 3)
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                if product.featuresGeo.count > 100 {
                    Button(action: {
                        showFullFeatures.toggle()
                    }) {
                        Text(showFullFeatures ? "Read less" : "Read more")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .padding(.horizontal)
                    }
                }
            }
            
            HStack {
                Text("Category:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text(product.category)
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
            .padding(.horizontal)
            
            HStack {
                Text("Supplier:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text(product.supplier)
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
            .padding(.horizontal)
            
            if let link = product.linkToURL {
                Link("product link", destination: link)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding(.horizontal)
            }
        }
    }
}

