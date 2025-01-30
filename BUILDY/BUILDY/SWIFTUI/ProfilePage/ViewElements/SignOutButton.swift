//
//  SignOutButton.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 30.01.25.
//

import SwiftUI

struct SignOutButton: View {
    var signOutAction: () -> Void

    var body: some View {
        Button(action: signOutAction) {
            Text("Sign Out")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .cornerRadius(16)
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}
