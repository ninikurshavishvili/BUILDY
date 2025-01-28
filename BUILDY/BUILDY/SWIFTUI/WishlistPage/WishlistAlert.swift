//
//  WishlistAlert.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 28.01.25.
//

import SwiftUI

struct WishlistAlert: View {
    @Binding var showAlert: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "heart.fill")
            Text("Added to wishlist")
                .fontWeight(.semibold)
        }
        .padding()
        .background(Color.gray.opacity(0.9))
        .cornerRadius(10)
        .foregroundColor(.white)
        .shadow(radius: 5)
        .offset(y: showAlert ? 0 : -100)
        .animation(.easeInOut(duration: 0.5), value: showAlert)
    }
}

