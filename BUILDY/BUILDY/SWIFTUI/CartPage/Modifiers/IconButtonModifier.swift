//
//  IconButtonModifier.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 30.01.25.
//

import SwiftUI

struct IconButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.black)
            .frame(width: 30, height: 30)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(6)
    }
}


struct ProductImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 100)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
}


struct QuantityButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.black)
            .frame(width: 30, height: 30)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(6)
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(height: 200)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
