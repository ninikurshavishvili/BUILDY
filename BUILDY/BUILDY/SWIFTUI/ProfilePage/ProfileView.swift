//
//  ProfileView.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 21.01.25.
//

import SwiftUI

struct ProfileView: View {
    let userName: String
    let userEmail: String

    var signOutAction: () -> Void

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(userName)
                            .font(.headline)
                        Text(userEmail)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding()

                Text("Account settings")
                    .font(.title3)
                    .bold()
                    .padding(.horizontal)

                List {
                    NavigationLink(destination: Text("My Account")) {
                        Label("My account", systemImage: "doc.text")
                    }
                    NavigationLink(destination: Text("My Orders")) {
                        Label("My orders", systemImage: "bag")
                    }
                    NavigationLink(destination: Text("Preferences")) {
                        Label("Preferences", systemImage: "gear")
                    }
                    NavigationLink(destination: Text("Permissions")) {
                        Label("Permissions", systemImage: "key")
                    }
                    NavigationLink(destination: Text("Support")) {
                        Label("Support", systemImage: "person.2")
                    }
                    NavigationLink(destination: Text("Contact")) {
                        Label("Contact", systemImage: "phone")
                    }
                }
                .listStyle(.plain)

                Spacer()

                Button(action: signOutAction) {
                    Text("Sign Out")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()
            }
            .navigationTitle("My Profile")
        }
    }
}
