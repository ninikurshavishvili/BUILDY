//
//  AuthorizationViewModel.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 04.01.25.
//


import FirebaseAuth
import FirebaseFirestore
import UIKit
import SwiftUI

class AuthorizationViewModel {
    var onSignInSuccess: ((User) -> Void)?
    var onSignInFailure: ((String) -> Void)?
    var onCreateAccountRequested: (() -> Void)?
    var onSignInRequested: (() -> Void)?

    private let db = Firestore.firestore()
    
    var isGuest: Bool {
        return UserDefaults.standard.bool(forKey: "isGuest")
    }

    var userID: String? {
        return Auth.auth().currentUser?.uid
    }
    
    // MARK: - Authentication Actions

    func signInTapped() {
        onSignInRequested?()
    }

    func createAccountTapped() {
        onCreateAccountRequested?()
    }

    func signIn(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            onSignInFailure?("Email and password must not be empty.")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                self.onSignInFailure?(error.localizedDescription)
                return
            }

            if let user = result?.user {
                self.storeUserSession(user: user)
            }
        }
    }

    func createAccount(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            onSignInFailure?("Email and password must not be empty.")
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                self.onSignInFailure?(error.localizedDescription)
                return
            }

            if let user = result?.user {
                self.storeUserSession(user: user)
            }
        }
    }
    
    func fetchUserProfile(completion: @escaping (String, String, String, String) -> Void) {
        guard let userID = userID else {
            completion("Guest", "Not available", "No Phone", "No Address")
            return
        }

        db.collection("users")
            .document(userID)
            .collection("userInfo")
            .document("profile")
            .getDocument { document, error in
                if let error = error {
                    print("Error fetching profile: \(error.localizedDescription)")
                    completion("Unknown User", "Unknown Email", "Unknown Phone", "Unknown Address")
                    return
                }

                guard let data = document?.data(),
                      let name = data["name"] as? String,
                      let email = data["email"] as? String,
                      let phone = data["phoneNumber"] as? String,
                      let address = data["address"] as? String else {
                    completion("Unknown User", "Unknown Email", "Unknown Phone", "Unknown Address")
                    return
                }

                completion(name, email, phone, address)
            }
    }


    private func storeUserSession(user: User) {
        UserDefaults.standard.set(user.uid, forKey: "userUID")
        UserDefaults.standard.set(false, forKey: "isGuest")

        let userDocRef = db.collection("users")
            .document(user.uid)
            .collection("userInfo")
            .document("profile")

        userDocRef.getDocument { document, error in
            if let document = document, document.exists {
                print("User profile already exists. Skipping default data save.")
            } else {
                let userInfo: [String: Any] = [
                    "name": user.displayName ?? "Unknown",
                    "email": user.email ?? "No Email",
                    "phoneNumber": user.phoneNumber ?? "No Phone",
                    "address": "No Address"
                ]

                userDocRef.setData(userInfo, merge: true) { error in
                    if let error = error {
                        print("Error saving user info: \(error.localizedDescription)")
                    } else {
                        print("User info saved successfully.")
                    }
                }
            }
        }

        CartManager.shared.fetchCartFromFirestore()
        WishlistManager.shared.fetchWishlistFromFirestore()

        onSignInSuccess?(user)
    }


    func enterAsGuest() {
        UserDefaults.standard.set(true, forKey: "isGuest")
        UserDefaults.standard.removeObject(forKey: "userUID")
    }

    func signOut() {
        do {
            try Auth.auth().signOut()  
            UserDefaults.standard.removeObject(forKey: "userUID")
            UserDefaults.standard.set(true, forKey: "isGuest")
            CartManager.shared.clearCart()
            print("sign out tapped from Authorisation VM ↖️↖️")

            AuthenticationManager.shared.navigateToAuthorization()

        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }


    func restoreSession() {
        if let user = Auth.auth().currentUser {
            storeUserSession(user: user)
        } else {
            enterAsGuest()
        }
    }
}



