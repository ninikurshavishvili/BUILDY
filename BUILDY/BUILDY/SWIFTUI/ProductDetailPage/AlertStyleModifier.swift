//
//  AlertStyleModifier.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 29.01.25.
//


import SwiftUI

struct AlertStyleModifier: ViewModifier {
    var iconColor: Color
    var backgroundColor: Color
    var textColor: Color

    func body(content: Content) -> some View {
        content
            .padding()
            .background(backgroundColor)
            .cornerRadius(12)
            .shadow(radius: 4)
            .foregroundColor(textColor)
            .padding()
    }
}
