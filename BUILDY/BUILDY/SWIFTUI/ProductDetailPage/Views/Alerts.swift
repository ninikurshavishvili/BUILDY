//
//  WishlistAlert.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 28.01.25.
//

import SwiftUI

struct WishlistAlert: View {
    var iconColor: Color = .black
    var body: some View {
        HStack {
            Image(systemName: "heart.fill")
                .foregroundColor(iconColor)
                .padding(.leading, 8)
            Text("Added to wishlist")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.trailing, 8)
            Spacer()
        }
        .modifier(AlertStyleModifier(iconColor: iconColor, backgroundColor: Color.gray.opacity(0.1), textColor: .black))
    }
}

struct CartAlert: View {
    var iconColor: Color = .black
    var body: some View {
        HStack {
            Image(systemName: "cart.fill")
                .foregroundColor(iconColor)
                .padding(.leading, 8)
            Text("Added to cart")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.trailing, 8)
            Spacer()
        }
        .modifier(AlertStyleModifier(iconColor: iconColor, backgroundColor: Color.gray.opacity(0.1), textColor: .black))
    }
}

struct DeleteAlert: View {
    var iconColor: Color = .red 
    var body: some View {
        HStack {
            Image(systemName: "trash.fill")
                .foregroundColor(iconColor)
                .padding(.leading, 8)
            Text("Deleted from wishlist")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.trailing, 8)
            Spacer()
        }
        .modifier(AlertStyleModifier(iconColor: iconColor, backgroundColor: Color.gray.opacity(0.1), textColor: .black))
    }
}
