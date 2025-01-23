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

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    if let image = profileManager.profileImage {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text(profileManager.userName)
                            .font(.headline)
                        Text(profileManager.userEmail)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding()
                .onAppear {
                    profileManager.fetchUserProfile()
                    profileManager.loadProfileImage()
                }

                Form {
                    Section(header: Text("Personal Info")) {
                        TextField("Name", text: $profileManager.userName)
                        TextField("Email", text: $profileManager.userEmail)
                            .disabled(true)
                        TextField("Phone Number", text: $profileManager.userPhone)
                        TextField("Address", text: $profileManager.userAddress)
                    }

                    Section {
                        Button("Save Changes") {
                            profileManager.updateUserProfile()
                        }
                    }

                    Section {
                        Button("Upload Profile Picture") {
                            pickImage()
                        }
                    }
                }

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
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.dismissToHome()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                    Text("Back")
                        .foregroundColor(.blue)
                }
            })
        }
    }
    
    private func pickImage() {

    }
    
    func dismissToHome() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {

            let homePageVC = MainTabBarController()
            let navController = UINavigationController(rootViewController: homePageVC)
            navController.modalPresentationStyle = .fullScreen
            window.rootViewController = navController
            window.makeKeyAndVisible()
        }
    }
}


