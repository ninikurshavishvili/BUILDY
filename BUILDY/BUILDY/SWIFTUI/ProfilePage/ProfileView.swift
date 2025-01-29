//
//  ProfileView.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 21.01.25.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var profileManager = ProfileManager()
    var signOutAction: () -> Void
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    NavigationLink(destination: PersonalInfoView(profileManager: profileManager)) {
                        HStack {
                            if let image = profileManager.profileImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            } else {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(.gray)
                            }

                            VStack(alignment: .leading) {
                                Text(profileManager.userName)
                                    .font(.headline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                Text("View personal info")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.blue)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                    }
                    .padding(.horizontal)

                    VStack(spacing: 0) {
                        SectionHeader(title: "Account Settings")

                        Group {
                            SettingsRow(title: "My Account", systemImage: "person")
                            Divider()
                            SettingsRow(title: "My Orders", systemImage: "doc.plaintext")
                            Divider()
                            SettingsRow(title: "Preferences", systemImage: "gear")
                            Divider()
                            SettingsRow(title: "Permissions", systemImage: "eye")
                            Divider()
                            SettingsRow(title: "Support", systemImage: "questionmark.circle")
                            Divider()
                            SettingsRow(title: "Contact", systemImage: "phone")
                        }
                        .foregroundStyle(.secondary)
                        .background(Color.white)
                        .padding(5)
                    }
                    .padding(.horizontal)

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
                .padding(.vertical)
                .background(Color.white)
            }
            .navigationBarTitle("Profile", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            })
            .background(Color.white)
            .onAppear {
                profileManager.fetchUserProfile()
                profileManager.loadProfileImage()
            }
        }
    }
}

struct SectionHeader: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 5)
    }
}

struct SettingsRow: View {
    var title: String
    var systemImage: String

    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .foregroundColor(.black)
            Text(title)
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "chevron.forward")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
    }
}



