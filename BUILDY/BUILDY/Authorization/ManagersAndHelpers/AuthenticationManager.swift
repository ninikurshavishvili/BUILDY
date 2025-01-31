//
//  AuthenticationManager.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 23.01.25.
//


import FirebaseFirestore
import GoogleSignIn
import FirebaseCore
import UIKit
import SwiftUI
import FirebaseAuth

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    private let db = Firestore.firestore()

    private init() {}

    var onSignInSuccess: ((User) -> Void)?
    var onSignInFailure: ((String) -> Void)?

    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.onSignInFailure?(error.localizedDescription)
                return
            }
            if let user = result?.user {
                self?.storeUserSession(user: user)
            }
        }
    }

    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            onSignInFailure?("Google Sign-In failed: No client ID found.")
            return
        }

        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)

        guard let topVC = UIApplication.getTopViewController() else {
            onSignInFailure?("Google Sign-In failed: Unable to get top view controller.")
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: topVC) { [weak self] result, error in
            guard let self = self, let user = result?.user, let idToken = user.idToken?.tokenString else {
                self?.onSignInFailure?("Google Sign-In failed: Unable to sign in.")
                return
            }

            let accessToken = user.accessToken.tokenString
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    self.onSignInFailure?("Google Sign-In failed: \(error.localizedDescription)")
                    return
                }
                if let user = result?.user {
                    self.storeUserSession(user: user)
                }
            }
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

    func restoreSession() {
        if let user = Auth.auth().currentUser {
            storeUserSession(user: user)
        } else {
            enterAsGuest()
        }
    }

    // MARK: - Guest Mode
    func enterAsGuest() {
        UserDefaults.standard.set(true, forKey: "isGuest")
        UserDefaults.standard.removeObject(forKey: "userUID")
    }

    // MARK: - Sign Out
    func signOut() {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "userUID")
            UserDefaults.standard.set(true, forKey: "isGuest")
            CartManager.shared.clearCart()
            navigateToAuthorization()
            print("User signed out successfully.")
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    func navigateToAuthorization() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let authorizationVC = AuthorizationPage()
            let navController = UINavigationController(rootViewController: authorizationVC)
            navController.modalPresentationStyle = .fullScreen
            window.rootViewController = navController
            window.makeKeyAndVisible()
        }
    }
    
    func createAccount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.onSignInFailure?(error.localizedDescription)
                return
            }
            if let user = result?.user {
                self?.onSignInSuccess?(user)
            }
        }
    }

}

