//
//  DriverInfoView.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 30.01.25.
//
import SwiftUI

struct DriverInfoView: View {
    var body: some View {
        HStack(spacing: 16) {
            Image("person")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())

            VStack(alignment: .leading) {
                Text("Driver: Jonny")
                    .font(.headline)
                Text("7ZDX878")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()

            HStack {
                Button(action: {}) {
                    Image(systemName: "phone.fill")
                        .foregroundColor(.customOrange)
                        .padding()
                        .background(Color.customOrange.opacity(0.1))
                        .clipShape(Circle())
                }
                Button(action: {}) {
                    Image(systemName: "message.fill")
                        .foregroundColor(.customOrange)
                        .padding()
                        .background(Color.customOrange.opacity(0.2))
                        .clipShape(Circle())
                }
            }
        }
        .padding()
    }
}
