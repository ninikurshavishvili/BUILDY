//
//  AuthorizationViewModel.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 04.01.25.
//


import FirebaseAuth
import FirebaseFirestore

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

            guard let user = result?.user else {
                self.onSignInFailure?("Unexpected error occurred.")
                return
            }

            self.storeUserSession(user: user)
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

            guard let user = result?.user else { return }

            self.storeUserSession(user: user)
        }
    }

    private func storeUserSession(user: User) {
        UserDefaults.standard.set(user.uid, forKey: "userUID")
        UserDefaults.standard.set(false, forKey: "isGuest")

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



