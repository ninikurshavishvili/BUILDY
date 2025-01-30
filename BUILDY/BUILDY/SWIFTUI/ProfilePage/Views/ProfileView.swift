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
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                    }
                    .padding(.horizontal)

                    AccountSettings()
                    
                    .padding(.horizontal)

                    SignOutButton(signOutAction: signOutAction)
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



